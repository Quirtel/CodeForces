import Foundation
import Moya

class ContestProvider: ContentProvider {
    private let contestProvider = MoyaProvider<ContestAPI>()
    
    func contestList(
        gym withGym: Bool = false,
        _ completion: @escaping (Result<[Contest]>) -> ()) {
        request(
            provider: contestProvider,
            target: ContestAPI.list(gym: withGym)) { (result: Result<[Contest]>) -> () in
                completion(result)
        }
    }
    
    func contestStatus(
        contestId withContestId: Int, handle withHandle: String?,
        from: Int?, count: Int?, _ completion: @escaping (Result<[Submission]>) -> ()) {
        request(
            provider: contestProvider,
            target: ContestAPI.status(
                contestId: withContestId,
                handle: withHandle,
                from: from,
                count: count)) { (result: Result<[Submission]>) -> () in
                    completion(result)
        }
    }
}
