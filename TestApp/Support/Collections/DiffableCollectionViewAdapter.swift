import Foundation
import UIKit

final class DiffableCollectionViewAdapter: NSObject {
    private let collectionView: UICollectionView
    private var sections: [ICollectionViewSection] = []
    private var dataSource: UICollectionViewDiffableDataSource<Int, UUID>?
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        setupDataSource()
        collectionView.delegate = self
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            self?.sections[indexPath.section].dequeueReusableCell(collectionView, cellForRowAt: indexPath, itemIdentifier: itemIdentifier)
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] (collectionView, supplementaryKind, indexPath) -> UICollectionReusableView? in
            var cell: UICollectionReusableView?
            if supplementaryKind == UICollectionView.elementKindSectionHeader {
                cell = self?.sections[indexPath.section].dequeueReusableHeader(collectionView, kind: supplementaryKind, indexPath: indexPath)
            } else {
                cell = self?.sections[indexPath.section].dequeueReusableHeader(collectionView, kind: supplementaryKind, indexPath: indexPath)
            }
            return cell
        }
        
        collectionView.dataSource = dataSource
    }
    
    func register<CellType: UICollectionViewCell>(cellType: CellType.Type) where CellType: CellIdentifiableProtocol {
        collectionView.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    func register<CellType: UICollectionReusableView>(
        headerFooterType: CellType.Type)
    where CellType: CellIdentifiableProtocol {
        collectionView.register(CellType.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerFooterType.reuseIdentifier)
    }
    
    func append(section: ICollectionViewSection) {
        sections.append(section)
        
        guard var snapshot = dataSource?.snapshot() else { return }
        snapshot.appendSections([section.id])
        snapshot.appendItems(section.getItemsIds(), toSection: section.id)
        
        dataSource?.apply(snapshot)
    }
    
    func reloadData() {
        guard var snapshot = dataSource?.snapshot() else { return }
        snapshot.reloadSections(sections.map({ $0.id }))
        dataSource?.apply(snapshot)
    }
    
    func reloadSection(section: ICollectionViewSection) {
        guard var snapshot = dataSource?.snapshot() else { return }
        snapshot.reloadSections([section.id])
        let itemsInSection = snapshot.itemIdentifiers(inSection: section.id)
        snapshot.deleteItems(itemsInSection)
        snapshot.appendItems(section.getItemsIds(), toSection: section.id)
        dataSource?.apply(snapshot)
    }
    
}

extension DiffableCollectionViewAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        sections[indexPath.section].selectionIsAllowed
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sections[indexPath.section].onItemSelected(at: indexPath.item)
    }
}

