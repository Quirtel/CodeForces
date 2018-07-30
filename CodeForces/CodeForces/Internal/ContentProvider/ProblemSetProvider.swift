import Foundation
import Moya

class ProblemSetProvider {
    private let problemSetPovider = MoyaProvider<ProblemSetAPI>()
    
    func problemsetProblems(
        withRequestParams: ProblemSetProblemsRequest,
        _ completion: @escaping (Result<ProblemSetProblems>) -> ()) {
        Provider.request(
            provider: problemSetPovider,
            target: ProblemSetAPI.problems(
                 requestParams: withRequestParams)) {
                    (result: Result<ProblemSetProblems>) -> () in
                    completion(result)
        }
    }
    
    func problemsetRecentStatus(
        withRequestParams: ProblemSetRecentStatusRequest,
        _ completion: @escaping (Result<[Submission]>) -> ()) {
        Provider.request(
            provider: problemSetPovider,
            target: ProblemSetAPI.recentStatus(
                requestParams: withRequestParams)) {
                    (result: Result<[Submission]>) -> () in
                    completion(result)
        }
    }
}
