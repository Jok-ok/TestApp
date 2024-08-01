import UIKit

protocol ICollectionViewSection {
    var id: Int { get }
    var count: Int { get }
    var isEditable: Bool { get }
    var selectionIsAllowed: Bool { get } 
    func getItemsIds() -> [UUID]
    func onItemSelected(at row: Int)
    func removeItem(at row: Int)
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> UICollectionViewCell
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath, itemIdentifier: UUID) -> UICollectionViewCell
    func dequeueReusableHeader(_ collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView
    func dequeueReusableFooter(_ collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView
}
