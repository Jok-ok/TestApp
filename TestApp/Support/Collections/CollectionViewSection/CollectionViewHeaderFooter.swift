import UIKit

class CollectionViewHeaderFooter<HeaderFooterCell: UICollectionReusableView &
                                CellIdentifiableProtocol &
                                CellConfigurableProtocol>:
                                    ICollectionViewSectionHeaderFooter {
    
    typealias HeaderFooterModel = HeaderFooterCell.Model

    private let cellModel: HeaderFooterModel

    init(cellModel: HeaderFooterModel) {
        self.cellModel = cellModel
    }

    func dequeReusableHeaderFooter(_ collectionView: UICollectionView, kind: String, for indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderFooterCell.reuseIdentifier, for: indexPath) as? HeaderFooterCell else { return UICollectionReusableView() }
        
        cell.configure(with: cellModel)
        
        return cell
    }
}
