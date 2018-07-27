import XCTest
import Moya

@testable import CodeForces

typealias CodeForcesResponse = CodeForces.Response

enum Errors: Error {
    case error
}

class CodeForcesNetworkTests: XCTestCase {
    let contestProvider = MoyaProvider<ContestAPI>()
    
    private func request<Target: TargetType, ResultType: Codable>(
            provider: MoyaProvider<Target>,
            target: Target,
            resultType: ResultType.Type) {
        provider.request(target) { result in
            switch result {
            case let .success(moyaResponse):
                switch moyaResponse.statusCode {
                case 200:
                    do {
                        let response = try moyaResponse.map(CodeForcesResponse<ResultType>.self)
                        switch response.status {
                        case .OK:
                            //BUG: broken
                            XCTAssert(response.result is ResultType.Type)
                            break
                        case .FAILED:
                            XCTFail()
                        }
                    } catch {
                        XCTFail()
                    }
                default:
                    XCTFail()
                }
            case .failure:
                XCTFail()
            }
        }
    }
    
    func testContestHacksAPI() {
        request(
            provider: contestProvider,
            target: ContestAPI.hacks(contestId: 655),
            resultType: [Hack].self)
    }
    
}
