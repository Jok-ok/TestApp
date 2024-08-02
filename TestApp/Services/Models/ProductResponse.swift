import Foundation

// MARK: - ProductResponse
struct ProductResponse: Codable {
    let status: Bool
    let menuList: [ProductDTO]
    let message: String?
}

// MARK: - MenuList
struct ProductDTO: Codable {
    let id, image, name, content: String
    let price: String
    let spicy, weight: String?
}
