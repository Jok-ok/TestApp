import UIKit.UIImage

class ProductItemCellModel: Identifiable {
    let id = UUID()
    let product_id, imagePath, name, content: String
    let price, weight: String
    let spicy: Bool
    var image: UIImage?
    let addToShopButtonText: String
    
    init(id: String, imagePath: String, name: String, content: String, price: String, weight: String, spicy: Bool, image: UIImage? = nil, addToShopButtonText: String) {
        self.product_id = id
        self.imagePath = imagePath
        self.name = name
        self.content = content
        self.price = price
        self.weight = weight
        self.spicy = spicy
        self.image = image
        self.addToShopButtonText = addToShopButtonText
    }    
}

