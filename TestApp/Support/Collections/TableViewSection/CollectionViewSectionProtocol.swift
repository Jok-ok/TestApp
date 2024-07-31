import UIKit

protocol CollectionViewSectionProtocol {
    var count: Int { get }
    var isEditable: Bool { get }
    func onItemSelected(at row: Int)
    func removeItem(at row: Int)
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> UICollectionViewCell
    func dequeueReusableHeader(_ collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView
    func dequeueReusableFooter(_ collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView
}
