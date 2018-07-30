import XCTest
import Moya

@testable import CodeForces

class ContestTests: CodeForcesNetworkTests {
    let contestProvider = MoyaProvider<ContestAPI>()
    
    func testContestHacks() {
        testRequest(
            provider: contestProvider,
            target: ContestAPI.hacks(requestParams: ContestHacksRequest(contestId: 566)),
            resultType: [Hack].self)
    }
    
    func testContestList() {
        testRequest(
            provider: contestProvider,
            target: ContestAPI.list(requestParams: ContestListRequest(gym: true)),
            resultType: [Contest].self)

        testRequest(
            provider: contestProvider,
            target: ContestAPI.list(requestParams: ContestListRequest(gym: false)),
            resultType: [Contest].self)
    }

    func testContestRatingChanges() {
        testRequest(
            provider: contestProvider,
            target: ContestAPI.ratingChanges(
                requestParams: ContestRatingChangesRequest(contestId: 655)),
            resultType: [RatingChange].self)
    }

    func testContestStandings() {
        testRequest(provider: contestProvider,
                    target: ContestAPI.standings(requestParams: ContestStandingsRequest(
                        contestId: 566, from: nil, count: nil, handles: nil, room: nil,
                        showUnofficial: false)), resultType: ContestStandings.self)
        
        testRequest(provider: contestProvider,
                    target: ContestAPI.standings(requestParams: ContestStandingsRequest(
                        contestId: 566, from: 2, count: 1, handles: nil, room: nil,
                        showUnofficial: false)), resultType: ContestStandings.self)
        
        testRequest(provider: contestProvider,
                    target: ContestAPI.standings(requestParams: ContestStandingsRequest(
                        contestId: 566, from: nil, count: nil, handles: ["rng_58"], room: 8,
                        showUnofficial: false)), resultType: ContestStandings.self)

    }

    func testContestStatus() {
        testRequest(
            provider: contestProvider,
            target: ContestAPI.status(requestParams: ContestStatusRequest(
                contestId: 566, handle: "rng_58", from: 1, count: 10)),
            resultType: [Submission].self)
    }

}
