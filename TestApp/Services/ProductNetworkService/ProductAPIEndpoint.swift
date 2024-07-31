import Foundation

enum ProductAPIEndpoint {
    private var baseURL: String { "https://vkus-sovet.ru/api/" }
    
    case getCategories
    case getProducts(inCategory: String)
}

extension ProductAPIEndpoint: APIEndpointProtocol {
    var method: HTTPMethod {
        switch self {
        case .getCategories:
                .get
        case .getProducts(_):
                .post
        }
    }

    var headers: [String: String] { [:] }

    var urlString: String {
        switch self {
        case .getCategories:
            baseURL + "getMenu.php"
        case .getProducts(_):
            baseURL + "getSubMenu.php"
        }
    }

    var queryItems: [String: String] {
        var queryItemsDict = [String:String]()
        
        switch self {
        case .getCategories:
            return queryItemsDict
        case .getProducts(let inCategory):
            queryItemsDict["menuID"] = inCategory
        }
        
        return queryItemsDict
    }
}
