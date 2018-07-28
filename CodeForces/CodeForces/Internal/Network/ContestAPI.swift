import Foundation
import Moya

enum ContestAPI {
    case hacks(contestId: Int)
    case list(gym: Bool)
    case ratingChanges(contestId: Int)
    case standings(
        contestId: Int, from: Int?, count: Int?,
        handles: [String]?, room: Int?, showUnofficial: Bool)
    case status(contestId: Int, handle: String?, from: Int?, count: Int?)
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
        var params: [String: Any] = [:]
        switch self {
        case .hacks(let contestId), .ratingChanges(let contestId):
            params["contestId"] = contestId
        case .list(let gym):
            params["gym"] = gym
        case .standings(let contestId, let from, let count, let handles, let room, let showUnofficial):
            params["contestId"] = contestId
            params["from"] = from
            params["count"] = count
            if let handles = handles {
                var handlString = ""
                for (id, handle) in handles.enumerated() {
                    handlString.append(handle)
                    if id < handles.count - 1 {
                        handlString.append(";")
                    }
                }
            }
            params["room"] = room
            params["showUnofficial"] = showUnofficial
        case .status(let contestId, let handle, let from, let count):
            params["contestId"] = contestId
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
