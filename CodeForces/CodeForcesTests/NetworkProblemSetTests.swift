import Foundation
import Moya

@testable import CodeForces

class ProblebSetTests: CodeForcesNetworkTests {
    let problemSetProvider = MoyaProvider<ProblemSetAPI>()
    
    func testProblems() {
        testRequest(
            provider: problemSetProvider,
            target: ProblemSetAPI.problems(tags: nil, problemsetName: nil),
            resultType: ProblemSetProblemsWrapper.self)
        
        testRequest(
            provider: problemSetProvider,
            target: ProblemSetAPI.problems(tags: ["implementation"], problemsetName: nil),
            resultType: ProblemSetProblemsWrapper.self)
        
        testRequest(
            provider: problemSetProvider,
            target: ProblemSetAPI.problems(
                tags: ["implementation", "binary search", "brute force"], problemsetName: nil),
            resultType: ProblemSetProblemsWrapper.self)
        
        testRequest(
            provider: problemSetProvider,
            target: ProblemSetAPI.problems(tags: ["implementation"], problemsetName: "acmsguru"),
            resultType: ProblemSetProblemsWrapper.self)
    }
    
    func testRecentStatus() {
        testRequest(
            provider: problemSetProvider,
            target: ProblemSetAPI.recentStatus(count: 10, problemsetName: nil),
            resultType: [Submission].self)
        
        testRequest(
            provider: problemSetProvider,
            target: ProblemSetAPI.recentStatus(count: 10, problemsetName: "acmsguru"),
            resultType: [Submission].self)
        
    }
}
