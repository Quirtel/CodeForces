import Foundation
import Moya

@testable import CodeForces

class ProblebSetTests: CodeForcesNetworkTests {
    let problemSetProvider = MoyaProvider<ProblemSetAPI>()

    func testProblems() {
        testRequest(
            provider: problemSetProvider,
            target: ProblemSetAPI.problems(
                requestParams: ProblemSetProblemsRequest(tags: nil, problemsetName: nil)),
            resultType: ProblemSetProblems.self)

        testRequest(
            provider: problemSetProvider,
            target: ProblemSetAPI.problems(
                requestParams: ProblemSetProblemsRequest(
                    tags: ["implementation"], problemsetName: nil)),
            resultType: ProblemSetProblems.self)

        testRequest(
            provider: problemSetProvider,
            target: ProblemSetAPI.problems(
                requestParams: ProblemSetProblemsRequest(
                tags: ["implementation", "binary search", "brute force"], problemsetName: nil)),
            resultType: ProblemSetProblems.self)

        testRequest(
            provider: problemSetProvider,
            target: ProblemSetAPI.problems(
                requestParams: ProblemSetProblemsRequest(
                    tags: ["implementation"], problemsetName: "acmsguru")),
            resultType: ProblemSetProblems.self)
    }

    func testRecentStatus() {
        testRequest(
            provider: problemSetProvider,
            target: ProblemSetAPI.recentStatus(
                requestParams: ProblemSetRecentStatusRequest(count: 10, problemsetName: nil)),
            resultType: [Submission].self)

        testRequest(
            provider: problemSetProvider,
            target: ProblemSetAPI.recentStatus(
                requestParams: ProblemSetRecentStatusRequest(count: 10, problemsetName: "acmsguru")),
            resultType: [Submission].self)

    }
}
