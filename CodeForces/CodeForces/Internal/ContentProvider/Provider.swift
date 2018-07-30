import Foundation
import Moya

final class Provider {
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
    
    func contestList(
        requestParams: ContestListRequest,
        _ completion: @escaping (Result<[Contest]>) -> ()) {
        Provider.request(
            provider: contestProvider,
            target: ContestAPI.list(requestParams: requestParams)) { (result: Result<[Contest]>) -> () in
                completion(result)
        }
    }
    
    func contestStatus(
        requestParams: ContestStatusRequest, _ completion: @escaping (Result<[Submission]>) -> ()) {
        Provider.request(
            provider: contestProvider,
            target: ContestAPI.status(requestParams: requestParams)) { (result: Result<[Submission]>) -> () in
                completion(result)
        }
    }
    
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
    
    func userRating(
        handle withHandle: String,
        _ completion: @escaping (Result<[RatingChange]>) -> ()) {
        Provider.request(
            provider: userProvider,
            target: UserAPI.rating(handle: withHandle)) { (result: Result<[RatingChange]>) -> () in
                completion(result)
        }
    }
    
    func userStatus(
        handle withHandle: String, from: Int?, count: Int?,
        _ completion: @escaping (Result<[Submission]>) -> ()) {
        Provider.request(
            provider: userProvider,
            target: UserAPI.status(handle: withHandle, from: from, count: count)) {
                (result: Result<[Submission]>) -> () in
                completion(result)
        }
    }
    
    
}
