import Foundation

protocol IProductNetworkService {
    func getCategories(completion: @escaping (Result<[CategoryDTO], APIErrors>) -> Void)
    func getProducts(inCategory category: String, completion: @escaping (Result<[ProductDTO], APIErrors>) -> Void)
}
