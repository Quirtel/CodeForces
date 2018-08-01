import Foundation
import Moya

final class NetworkService {
    private let contestProvider = MoyaProvider<ContestAPI>()
    private let problemSetPovider = MoyaProvider<ProblemSetAPI>()
    private let userProvider = MoyaProvider<UserAPI>()
    
    static func request<Target: TargetType, ResultType: Codable>(
        provider: MoyaProvider<Target>,
        target: Target,
        completion: @escaping (Result<ResultType>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(moyaResponse):
                switch moyaResponse.statusCode {
                case 200:
                    do {
                        let response = try moyaResponse.map(Response<ResultType>.self)
                        switch response.status {
                        case .ok:
                            if let payload = response.result {
                                DispatchQueue.main.async {
                                    completion(Result.success(payload))
                                }
                            }
                        case .failed:
                            DispatchQueue.main.async {
                                completion(Result.error(
                                    NetworkErrors.responseStatusFailed(
                                        comment: response.comment ?? "no comment")))
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(Result.error(CommonErrors.error(
                                description: "Error catched: \(error.localizedDescription)")))
                        }
                    }
                default:
                    DispatchQueue.main.async {
                        completion(Result.error(
                            NetworkErrors.badResponseCode(code: moyaResponse.statusCode)))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(Result.error(NetworkErrors.connectionError(moyaError: error)))
                }
            }
        }
    }
    
    func fetchContestList(
        requestParams: ContestListRequest,
        _ completion: @escaping (Result<[Contest]>) -> ()) {
        NetworkService.request(
            provider: contestProvider,
            target: ContestAPI.list(
                requestParams: requestParams)) {
                    (result: Result<[Contest]>) -> () in
                completion(result)
        }
    }
    
    func fetchContestStatus(
        requestParams: ContestStatusRequest,
        _ completion: @escaping (Result<[Submission]>) -> ()) {
        NetworkService.request(
            provider: contestProvider,
            target: ContestAPI.status(
                requestParams: requestParams)) {
                    (result: Result<[Submission]>) -> () in
                completion(result)
        }
    }
    
    func fetchContestStandings(
        requestParams: ContestStandingsRequest,
        _ completion: @escaping (Result<ContestStandings>) -> ()) {
        NetworkService.request(
            provider: contestProvider,
            target: ContestAPI.standings(
                requestParams: requestParams)) {
                    (result: Result<ContestStandings>) -> () in
                completion(result)
        }
    }
    
    func fetchContestRatingChanges(
        requestParams: ContestRatingChangesRequest,
        _ completion: @escaping (Result<[RatingChange]>) -> ()) {
        NetworkService.request(
            provider: contestProvider,
            target: ContestAPI.ratingChanges(
                requestParams: requestParams)) {
                    (result: Result<[RatingChange]>) -> () in
                    completion(result)
        }
    }
    
    func fetchProblemsetProblems(
        withRequestParams: ProblemSetProblemsRequest,
        _ completion: @escaping (Result<ProblemSetProblems>) -> ()) {
        NetworkService.request(
            provider: problemSetPovider,
            target: ProblemSetAPI.problems(
                requestParams: withRequestParams)) {
                    (result: Result<ProblemSetProblems>) -> () in
                completion(result)
        }
    }
    
    func fetchProblemsetRecentStatus(
        withRequestParams: ProblemSetRecentStatusRequest,
        _ completion: @escaping (Result<[Submission]>) -> ()) {
        NetworkService.request(
            provider: problemSetPovider,
            target: ProblemSetAPI.recentStatus(
                requestParams: withRequestParams)) {
                    (result: Result<[Submission]>) -> () in
                completion(result)
        }
    }
    
    func fetchUserRating(
        withRequestParams: UserRatingRequest,
        _ completion: @escaping (Result<[RatingChange]>) -> ()) {
        NetworkService.request(
            provider: userProvider,
            target: UserAPI.rating(
                requestParams: withRequestParams)) {
                    (result: Result<[RatingChange]>) -> () in
                completion(result)
        }
    }
    
    func fetchUserStatus(
        withRequestParams: UserStatusRequest,
        _ completion: @escaping (Result<[Submission]>) -> ()) {
        NetworkService.request(
            provider: userProvider,
            target: UserAPI.status(
                requestParams: withRequestParams)) {
                    (result: Result<[Submission]>) -> () in
                completion(result)
        }
    }
}
