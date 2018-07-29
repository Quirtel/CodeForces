import Foundation
import Moya

class ProblemSetProvider: Provider {
    private let problemSetPovider = MoyaProvider<ProblemSetAPI>()
    
    func problemsetProblems(
        tags withTags: [String]?, problemsetName withProblemSetname: String?,
        _ completion: @escaping (Result<ProblemSetProblemsWrapper>) -> ()) {
        request(
            provider: problemSetPovider,
            target: ProblemSetAPI.problems(
                tags: withTags,
                problemsetName: withProblemSetname)) {
                    (result: Result<ProblemSetProblemsWrapper>) -> () in
                    completion(result)
        }
    }
    
    func problemsetRecentStatus(
        count withCount: Int, problemsetName withProblemsetName: String?,
        _ completion: @escaping (Result<[Submission]>) -> ()) {
        request(
            provider: problemSetPovider,
            target: ProblemSetAPI.recentStatus(
                count: withCount, problemsetName: withProblemsetName)) {
                    (result: Result<[Submission]>) -> () in
                    completion(result)
        }
    }
}
