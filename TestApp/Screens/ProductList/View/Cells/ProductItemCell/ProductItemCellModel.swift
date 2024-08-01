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
    
    convenience init(with productDTO: ProductDTO, addToShopButtonText: String, imagePath: String) {
        self.init(id: productDTO.id,
                  imagePath: imagePath,
                  name: productDTO.name,
                  content: productDTO.content,
                  price: productDTO.price.replacing(".00", with: "", maxReplacements: 1) + "₽",
                  weight: "/ " + (productDTO.weight ?? "-"),
                  spicy: productDTO.spicy == "Y" ? true : false,
                  addToShopButtonText: addToShopButtonText)
    }
    
}

