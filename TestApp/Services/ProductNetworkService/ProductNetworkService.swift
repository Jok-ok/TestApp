import Foundation

final class ProductNetworkService: IProductNetworkService {
    func getCategories(completion: @escaping (Result<[CategoryDTO], APIErrors>) -> Void) {
        APINetworkManager.request(
            to: ProductAPIEndpoint.getCategories) { (result: Result<CategoryResponse, APIErrors>) in
            switch result {
            case .success(let categoryResponse):
                
                if !categoryResponse.status {
                    if let message = categoryResponse.message {
                        completion(.failure(.requestFailed(description: message)))
                    } else {
                        completion(.failure(.noDataInResponse))
                    }
                }
                
                completion(.success(categoryResponse.menuList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getProducts(inCategory category: String, completion: @escaping (Result<[ProductDTO], APIErrors>) -> Void) {
        APINetworkManager.request(
            to: ProductAPIEndpoint.getProducts(inCategory: category)) { (result: Result<ProductResponse, APIErrors>) in
            switch result {
            case .success(let productResponse):
                
                if !productResponse.status {
                    if let message = productResponse.message {
                        completion(.failure(.requestFailed(description: message)))
                    } else {
                        completion(.failure(.noDataInResponse))
                    }
                }
                
                completion(.success(productResponse.menuList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
