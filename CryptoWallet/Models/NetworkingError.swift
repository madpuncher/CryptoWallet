import Foundation

enum NetworkingError: LocalizedError {
    case badURLResponse(url: URL)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse:
            return "ERROR: Oh, we have problems with URL response"
        case .unknown:
            return "ERROR: Oh, we don't know what happened with network..."
        }
    }
}
