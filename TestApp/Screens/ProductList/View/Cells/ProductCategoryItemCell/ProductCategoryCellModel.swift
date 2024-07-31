import Foundation

struct ProductCategoryCellModel {
    let imagePath: String
    let id: String
    let name: String
    let subMenuItemsCount: Int
}

extension ProductCategoryCellModel {
    init(with categoryDTO: CategoryDTO) {
        self.init(imagePath: categoryDTO.image, id: categoryDTO.menuID, name: categoryDTO.name, subMenuItemsCount: categoryDTO.subMenuCount)
    }
}
