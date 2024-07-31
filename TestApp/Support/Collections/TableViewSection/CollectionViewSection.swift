import UIKit

class CollectionViewSection<Cell: UICollectionViewCell &
                        CellConfigurableProtocol &
                        CellIdentifiableProtocol>: CollectionViewSectionProtocol {
    typealias CellModel = Cell.Model
    typealias Cell = Cell
    typealias CellModelHandler = (CellModel) -> Void

    private var tapHandler: CellModelHandler?
    private let removeItemHandler: CellModelHandler?

    private var header: CollectionViewSectionHeaderFooterProtocol?
    private var footer: CollectionViewSectionHeaderFooterProtocol?

    var isEditable: Bool

    var items: [CellModel]

    var count: Int {
        items.count
    }

    init(items: [CellModel] = [],
         isEditable: Bool = false,
         tapHandler: CellModelHandler? = nil,
         removeItemHandler: CellModelHandler? = nil) {
        self.isEditable = isEditable
        self.tapHandler = tapHandler
        self.removeItemHandler = removeItemHandler
        self.items = items
    }

    func onItemSelected(at row: Int) {
        tapHandler?(items[row])
    }

    func removeItem(at row: Int) {
        let removedItem = items.remove(at: row)
        removeItemHandler?(removedItem)
    }

    func dequeueReusableCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: Cell.self, for: indexPath)
        cell.configure(with: items[indexPath.row])
        return cell
    }

    func setHeaderCell(with cell: CollectionViewSectionHeaderFooterProtocol) {
        header = cell
    }

    func setFooterCell(with cell: CollectionViewSectionHeaderFooterProtocol) {
        footer = cell
    }

    func dequeueReusableHeader(_ collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        header?.dequeReusableHeaderFooter(collectionView, kind: kind, for: indexPath) ?? UICollectionReusableView()
    }

    func dequeueReusableFooter(_ collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        footer?.dequeReusableHeaderFooter(collectionView, kind: kind, for: indexPath) ?? UICollectionReusableView()
    }

    func setTapHandler(_ handler: CellModelHandler?) {
        tapHandler = handler
    }
}
