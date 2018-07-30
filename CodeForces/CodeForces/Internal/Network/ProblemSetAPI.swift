import Foundation
import Moya

enum ProblemSetAPI {
    case problems(tags: [String]?, problemsetName: String?)
    case recentStatus(count: Int, problemsetName: String?)
}

extension ProblemSetAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://codeforces.com/api")!
    }
    
    var path: String {
        switch self {
        case .problems:
            return "problemset.problems"
        case .recentStatus:
            return "problemset.recentStatus"
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
        case .problems(let tags, let problemsetName):
            params["tags"] = tags.semicolonSeparated
            params["problemsetName"] = problemsetName
        case .recentStatus(let count, let problemsetName):
            params["count"] = count
            params["problemsetName"] = problemsetName
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return ["accept" : "application/json",
                "Content-Type" : "application/json"
        ]
    }
}
