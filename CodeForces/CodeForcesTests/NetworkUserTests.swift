import Foundation
import Moya

@testable import CodeForces

class UserTests: CodeForcesNetworkTests {
    let userProvider = MoyaProvider<UserAPI>()
    
    func testRating() {
        testRequest(
            provider: userProvider,
            target: UserAPI.rating(requestParams: UserRatingRequest(handle: "Fefer_Ivan")),
            resultType: [RatingChange].self)
    }
    
    func testStatus() {
        testRequest(
            provider: userProvider,
            target: UserAPI.status(
                requestParams: UserStatusRequest(handle: "Fefer_Ivan", from: nil, count: nil)),
            resultType: [Submission].self)
        
        testRequest(
            provider: userProvider,
            target: UserAPI.status(
                requestParams: UserStatusRequest(handle: "Fefer_Ivan", from: nil, count: 10)),
            resultType: [Submission].self)
        
        testRequest(
            provider: userProvider,
            target: UserAPI.status(
                requestParams: UserStatusRequest(handle: "Fefer_Ivan", from: 1, count: 10)),
            resultType: [Submission].self)
    }
    
}
