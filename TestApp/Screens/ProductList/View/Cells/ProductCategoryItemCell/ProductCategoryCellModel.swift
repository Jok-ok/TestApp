import UIKit.UIImage

class ProductCategoryCellModel: Identifiable {
    let id = UUID()
    let imagePath: String
    let category_id: String
    let name: String
    let subMenuItemsText: String
    var image: UIImage?
    
    init(imagePath: String, id: String, name: String, subMenuItemsText: String, image: UIImage? = nil) {
        self.imagePath = imagePath
        self.category_id = id
        self.name = name
        self.subMenuItemsText = subMenuItemsText
        self.image = image
    }
}
