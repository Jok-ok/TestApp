import UIKit

class CollectionViewAdapter: NSObject {
    private weak var collectionView: UICollectionView?
    private var sections: [CollectionViewSectionProtocol] = []
    private var hidedSectionIndexes = Set<Int>()

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()

        setupCollection()
    }

    func hideSection(with index: Int) {
        hidedSectionIndexes.insert(index)
    }

    func showSection(with index: Int) {
        hidedSectionIndexes.remove(index)
    }

    func register<CellType: UICollectionViewCell>(cellType: CellType.Type) where CellType: CellIdentifiableProtocol {
        collectionView?.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    func register<CellType: UICollectionReusableView>(
        headerFooterType: CellType.Type)
    where CellType: CellIdentifiableProtocol {
        collectionView?.register(CellType.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerFooterType.reuseIdentifier)
    }

    private func setupCollection() {
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }

    func configure(with sections: [CollectionViewSectionProtocol]) {
        self.sections = sections
    }

    func append(section: CollectionViewSectionProtocol) {
        self.sections.append(section)
    }

    func reloadCollectionView() {
        collectionView?.performBatchUpdates({
            collectionView?.reloadData()
        })
    }

    func reloadSection(_ section: Int ) {
        collectionView?.performBatchUpdates({
            collectionView?.reloadSections(IndexSet(integer: section))
        })
    }

    func insertRow(at section: Int, row: Int) {
        if !hidedSectionIndexes.contains(section) {
            collectionView?.performBatchUpdates({
                collectionView?.insertItems(at: [IndexPath(row: row, section: section)])
            })
        }
    }

    func removeRow(at section: Int, row: Int) {
        if !hidedSectionIndexes.contains(section) {
            collectionView?.performBatchUpdates({
                collectionView?.deleteItems(at: [IndexPath(row: row, section: section)])
            })
        }
    }

    func reloadRow(at section: Int, row: Int) {
        if !hidedSectionIndexes.contains(section) {
            collectionView?.performBatchUpdates({
                collectionView?.reloadItems(at: [IndexPath(row: row, section: section)])
            })
        }
    }
}

extension CollectionViewAdapter: UICollectionViewDataSource {    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if hidedSectionIndexes.contains(section) { return 0 } else { return sections[section].count }
    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        sections[indexPath.section].isEditable
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        sections[indexPath.section].dequeueReusableCell(collectionView, cellForRowAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            return sections[indexPath.section].dequeueReusableHeader(collectionView, kind: kind, indexPath: indexPath)
        } else if kind == UICollectionView.elementKindSectionFooter {
            return sections[indexPath.section].dequeueReusableFooter(collectionView, kind: kind, indexPath: indexPath)
        }
        
        return UICollectionReusableView()
    }
}

extension CollectionViewAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sections[indexPath.section].onItemSelected(at: indexPath.row)
    }
}
