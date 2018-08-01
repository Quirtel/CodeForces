import Foundation
import Moya

enum ProblemSetAPI {
    case problems(requestParams: ProblemSetProblemsRequest)
    case recentStatus(requestParams: ProblemSetRecentStatusRequest)
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
        switch self {
        case .problems(let requestParams):
            return .requestParameters(
                parameters: requestParams.dictionary, encoding: URLEncoding.queryString)
        case .recentStatus(let requestParams):
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
