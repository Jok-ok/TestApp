import UIKit

class CollectionViewSection<Cell: UICollectionViewCell &
                        CellConfigurableProtocol &
                                CellIdentifiableProtocol>: ICollectionViewSection where Cell.Model: Identifiable {
    var id: Int
    
    typealias CellModel = Cell.Model
    typealias Cell = Cell
    typealias CellModelHandler = (CellModel) -> Void

    private var tapHandler: CellModelHandler?
    private let removeItemHandler: CellModelHandler?

    private var header: ICollectionViewSectionHeaderFooter?
    private var footer: ICollectionViewSectionHeaderFooter?

    var isEditable: Bool
    var selectionIsAllowed: Bool = true

    var items: [CellModel]

    var count: Int {
        items.count
    }

    init(sectionId: Int, items: [CellModel] = [],
         isEditable: Bool = false,
         tapHandler: CellModelHandler? = nil,
         removeItemHandler: CellModelHandler? = nil, allowSelection: Bool = true) {
        self.id = sectionId
        self.isEditable = isEditable
        self.tapHandler = tapHandler
        self.removeItemHandler = removeItemHandler
        self.items = items
        selectionIsAllowed = allowSelection
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
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath, itemIdentifier: UUID) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: Cell.self, for: indexPath)
        if let item = items.first(where: { $0.id as? UUID == itemIdentifier }) {
            cell.configure(with: item)
        }
        return cell
    }

    func setHeaderCell(with cell: ICollectionViewSectionHeaderFooter) {
        header = cell
    }
    
    func getItemsIds() -> [UUID] {
        items.compactMap({ $0.id as? UUID })
    }

    func setFooterCell(with cell: ICollectionViewSectionHeaderFooter) {
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
