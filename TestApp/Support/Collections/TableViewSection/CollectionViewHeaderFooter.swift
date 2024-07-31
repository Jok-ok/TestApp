import UIKit

class CollectionViewHeaderFooter<HeaderFooterCell: UICollectionReusableView &
                                CellIdentifiableProtocol &
                                CellConfigurableProtocol>:
                                    CollectionViewSectionHeaderFooterProtocol {
    
    typealias HeaderFooterModel = HeaderFooterCell.Model

    private let cellModel: HeaderFooterModel

    init(cellModel: HeaderFooterModel) {
        self.cellModel = cellModel
    }

    func dequeReusableHeaderFooter(_ collectionView: UICollectionView, kind: String, for indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderFooterCell.reuseIdentifier, for: indexPath)
        return cell
    }
}
