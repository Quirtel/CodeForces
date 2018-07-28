import Foundation
import Moya

class ContentProvider {
    private let contestProvider = MoyaProvider<ContestAPI>()
    
    private func request<Target: TargetType, ResultType: Codable>(
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
                        case .OK:
                            if let payload = response.result {
                                DispatchQueue.main.async {
                                    completion(Result.success(payload))
                                }
                            }
                        case .FAILED:
                            DispatchQueue.main.async {
                                completion(Result.error(
                                    NetworkErrors.responseStatusFailed(
                                        comment: response.comment ?? "No comment")))
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
    
    func getContestList(
            gym withGym: Bool = false,
            _ completion: @escaping (Result<[Contest]>) -> ()) {
        request(
        provider: contestProvider,
        target: ContestAPI.list(gym: withGym)) { (result: Result<[Contest]>) -> () in
            completion(result)
        }
    }
    
    func getContestStatus(
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
