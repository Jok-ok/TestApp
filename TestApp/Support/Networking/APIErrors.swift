import Foundation

enum APIErrors: Error {
    case invalidUrl
    case invalidData
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknownError(error: Error)
    case noDataInResponse

    var localizedDescription: String {
        switch self {
        case .invalidUrl: return "Invalid URL"
        case .invalidData: return "Invalid data"
        case .jsonParsingFailure: return "Ошибка получения данных, перезапустите приложение"
        case .requestFailed(description: let description): return "Request failed: \(description)"
        case .invalidStatusCode(statusCode: let statusCode): return "Invalid status code: \(statusCode)"
        case .unknownError(error: let error): return "Неизвестная ошибка \(error.localizedDescription)"
        case .noDataInResponse: return "No suitable data"
        }
    }
}
