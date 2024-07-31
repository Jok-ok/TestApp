import Foundation

final class ProductNetworkService: IProductNetworkService {
    func getCategories(completion: @escaping (Result<[CategoryDTO], APIErrors>) -> Void) {
        APINetworkManager.request(
            to: ProductAPIEndpoint.getCategories) { [weak self] (result: Result<CategoryResponse, APIErrors>) in
            guard let self else { return }
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
            to: ProductAPIEndpoint.getProducts(inCategory: category)) { [weak self] (result: Result<ProductResponse, APIErrors>) in
            guard let self else { return }
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
