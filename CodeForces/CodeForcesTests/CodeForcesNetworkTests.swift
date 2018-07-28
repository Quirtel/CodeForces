import XCTest
import Moya

@testable import CodeForces

typealias CodeForcesResponse = CodeForces.Response

enum Errors: Error {
    case error
}

class CodeForcesNetworkTests: XCTestCase {
    let contestProvider = MoyaProvider<ContestAPI>()
    
    private func testRequest<Target: TargetType, ResultType: Codable>(
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
                        case .OK:
                            guard response.result != nil else { XCTFail(); break }
                        case .FAILED:
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
    
    func testContestHacks() {
        testRequest(
            provider: contestProvider,
            target: ContestAPI.hacks(contestId: 566),
            resultType: [Hack].self)
    }
    
    func testContestList() {
        testRequest(
            provider: contestProvider,
            target: ContestAPI.list(gym: true),
            resultType: [Contest].self)
        
        testRequest(
            provider: contestProvider,
            target: ContestAPI.list(gym: false),
            resultType: [Contest].self)
    }
    
    func testContestRatingChanges() {
        testRequest(
            provider: contestProvider,
            target: ContestAPI.ratingChanges(contestId: 566),
            resultType: [RatingChange].self)
    }
    
    func testContestStandings() {
        testRequest(provider: contestProvider,
                    target: ContestAPI.standings(
                        contestId: 566, from: nil, count: nil, handles: nil, room: nil,
                        showUnofficial: false), resultType: ContestStandingsWrapper.self)
        
        testRequest(provider: contestProvider,
                    target: ContestAPI.standings(
                        contestId: 566, from: 2, count: 1, handles: nil, room: nil,
                        showUnofficial: true), resultType: ContestStandingsWrapper.self)
        
        testRequest(provider: contestProvider,
                    target: ContestAPI.standings(
                        contestId: 566, from: nil, count: nil,
                        handles: ["rng_58"], room: 8,
                        showUnofficial: false), resultType: ContestStandingsWrapper.self)
        
    }
    
    func testContestStatus() {
        testRequest(
            provider: contestProvider,
            target: ContestAPI.status(
                contestId: 566, handle: "rng_58", from: 1, count: 10),
            resultType: [Submission].self)
    }
}
