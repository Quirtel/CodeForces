import Foundation
import Moya

enum UserAPI {
    case rating(requestParams: UserRatingRequest)
    case status(requestParams: UserStatusRequest)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://codeforces.com/api")!
    }
    
    var path: String {
        switch self {
        case .rating:
            return "user.rating"
        case .status:
            return "user.status"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .rating(let requestParams):
            return .requestParameters(
                parameters: requestParams.dictionary, encoding: URLEncoding.queryString)
        case .status(let requestParams):
            return .requestParameters(
                parameters: requestParams.dictionary, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["accept" : "application/json",
                "Content-Type" : "application/json"
        ]
    }
}
