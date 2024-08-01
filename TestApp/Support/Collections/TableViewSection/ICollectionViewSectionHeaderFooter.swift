import UIKit.UITableView

protocol ICollectionViewSectionHeaderFooter {
    func dequeReusableHeaderFooter(_ collectionView: UICollectionView, kind: String, for indexPath: IndexPath) -> UICollectionReusableView
}
