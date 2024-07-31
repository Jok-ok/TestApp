import UIKit

extension UICollectionView {
    func dequeueReusableCell<CellType: UICollectionViewCell>(
        with cellType: CellType.Type,
        for indexPath: IndexPath
    ) -> CellType where CellType: CellIdentifiableProtocol {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? CellType
        else { return CellType() }

        return cell
    }
}
