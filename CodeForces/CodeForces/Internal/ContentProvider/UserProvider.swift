import Foundation
import Moya

class UserProvider {
    private let userProvider = MoyaProvider<UserAPI>()
    
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
