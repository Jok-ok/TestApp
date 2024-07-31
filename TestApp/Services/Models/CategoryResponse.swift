import Foundation

// MARK: - CategoryResponse
struct CategoryResponse: Codable {
    let status: Bool
    let menuList: [CategoryDTO]
    let message: String?
}

// MARK: - CategoryMenuList
struct CategoryDTO: Codable {
    let menuID, image, name: String
    let subMenuCount: Int
}
