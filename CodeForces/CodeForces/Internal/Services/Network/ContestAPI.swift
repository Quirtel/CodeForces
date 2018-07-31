import Foundation
import Moya

enum ContestAPI {
    case hacks(requestParams: ContestHacksRequest)
    case list(requestParams: ContestListRequest)
    case ratingChanges(requestParams: ContestRatingChangesRequest)
    case standings(requestParams: ContestStandingsRequest)
    case status(requestParams: ContestStatusRequest)
}

extension ContestAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://codeforces.com/api")!
    }
    
    var path: String {
        switch self {
        case .hacks:
            return "contest.hacks"
        case .list:
            return "contest.list"
        case .ratingChanges:
            return "contest.ratingChanges"
        case .standings:
            return "contest.standings"
        case .status:
            return "contest.status"
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
        case .hacks(let requestParams):
            return .requestParameters(
                parameters: requestParams.dictionary, encoding: URLEncoding.queryString)
        case .list(let requestParams):
            return .requestParameters(
                parameters: requestParams.dictionary, encoding: URLEncoding.queryString)
        case .ratingChanges(let requestParams):
            return .requestParameters(
                parameters: requestParams.dictionary, encoding: URLEncoding.queryString)
        case .standings(let requestParams):
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
