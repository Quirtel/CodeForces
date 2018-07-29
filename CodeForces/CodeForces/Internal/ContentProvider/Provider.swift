import Foundation
import Moya

class Provider {
    func request<Target: TargetType, ResultType: Codable>(
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
    
}
