import Foundation

struct ProductItemCellModel {
    let id, image, name, content: String
    let price, weight: String
    let spicy: Bool
}

extension ProductItemCellModel {
    init(with productDTO: ProductDTO) {
        self.init(id: productDTO.id,
                  image: productDTO.image,
                  name: productDTO.name,
                  content: productDTO.content,
                  price: productDTO.price, 
                  weight: productDTO.weight,
                  spicy: productDTO.spicy == "Y" ? true : false)
    }
}
