import Foundation
import Moya

enum UserAPI {
    case rating(handle: String)
    case status(handle: String, from: Int?, count: Int?)
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
        var params: [String: Any] = [:]
        switch self {
        case .rating(let handle):
            params["handle"] = handle
        case .status(let handle, let from, let count):
            params["handle"] = handle
            params["from"] = from
            params["count"] = count
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return ["accept" : "application/json",
                "Content-Type" : "application/json"
        ]
    }
}
