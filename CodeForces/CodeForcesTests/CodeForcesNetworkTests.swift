import XCTest
import Moya

@testable import CodeForces

typealias CodeForcesResponse = CodeForces.Response

class CodeForcesNetworkTests: XCTestCase {
    
    final func testRequest<Target: TargetType, ResultType: Codable>(
                provider: MoyaProvider<Target>,
                target: Target,
                resultType: ResultType.Type) {
            let expectation = XCTestExpectation(
                description: "Testing \(provider) with target \(target)")
            provider.request(target) { result in
                switch result {
                case let .success(moyaResponse):
                    switch moyaResponse.statusCode {
                    case 200:
                        do {
                            let response = try moyaResponse.map(CodeForcesResponse<ResultType>.self)
                            switch response.status {
                            case .ok:
                                guard response.result != nil else { XCTFail(); break }
                            case .failed:
                                XCTFail()
                            }
                        } catch {
                            XCTFail("Decode error catched: \(error)")
                        }
                    default:
                        XCTFail("Bad response status code: \(moyaResponse.statusCode)")
                    }
                case .failure(let error):
                    XCTFail("Moya error: \(error)")
                }
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 30.0)
        }
}
