import UIKit.UIImage

class ProductCategoryCellModel {
    let imagePath: String
    let id: String
    let name: String
    let subMenuItemsText: String
    var image: UIImage?
    
    init(imagePath: String, id: String, name: String, subMenuItemsText: String, image: UIImage? = nil) {
        self.imagePath = imagePath
        self.id = id
        self.name = name
        self.subMenuItemsText = subMenuItemsText
        self.image = image
    }
}
