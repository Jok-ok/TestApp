import UIKit.UITableView

protocol CollectionViewSectionHeaderFooterProtocol {
    func dequeReusableHeaderFooter(_ collectionView: UICollectionView, kind: String, for indexPath: IndexPath) -> UICollectionReusableView
}
