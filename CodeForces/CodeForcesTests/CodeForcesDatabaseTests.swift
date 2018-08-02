import XCTest
import RealmSwift

@testable import CodeForces

class CodeForcesDatabaseTests: XCTestCase {
    let realmService = RealmService()
    
    func testRealmContestList() {
        let contests = [
            Contest(id: 12, name: "name1", type: ContestType.captureTheFlag,
                    phase: PhaseType.before, frozen: false, durationSeconds: 300,
                    startTimeSeconds: nil, relativeTimeSeconds: nil, preparedBy: nil,
                    websiteUrl: nil, descr1ption: nil, difficulty: nil, kind: nil, icpcRegion: nil,
                    country: nil, city: nil, season: "season"),
            Contest(id: 22, name: "name2", type: ContestType.captureTheFlag,
                    phase: PhaseType.before, frozen: false, durationSeconds: 300,
                    startTimeSeconds: nil, relativeTimeSeconds: nil, preparedBy: nil,
                    websiteUrl: nil, descr1ption: nil, difficulty: nil, kind: nil, icpcRegion: nil,
                    country: nil, city: nil, season: "season"),
            Contest(id: 32, name: "name3", type: ContestType.captureTheFlag,
                    phase: PhaseType.before, frozen: false, durationSeconds: 300,
                    startTimeSeconds: nil, relativeTimeSeconds: nil, preparedBy: nil,
                    websiteUrl: nil, descr1ption: nil, difficulty: nil, kind: nil, icpcRegion: nil,
                    country: nil, city: nil, season: "season"),
            Contest(id: 42, name: "name4", type: ContestType.captureTheFlag,
                    phase: PhaseType.before, frozen: false, durationSeconds: 300,
                    startTimeSeconds: nil, relativeTimeSeconds: nil, preparedBy: nil,
                    websiteUrl: nil, descr1ption: nil, difficulty: nil, kind: nil, icpcRegion: nil,
                    country: nil, city: nil, season: "season"),
            Contest(id: 52, name: "name5", type: ContestType.captureTheFlag,
                    phase: PhaseType.before, frozen: false, durationSeconds: 300,
                    startTimeSeconds: nil, relativeTimeSeconds: nil, preparedBy: nil,
                    websiteUrl: nil, descr1ption: nil, difficulty: nil, kind: nil, icpcRegion: nil,
                    country: nil, city: nil, season: "season"),
            Contest(id: 62, name: "name6", type: ContestType.captureTheFlag,
                    phase: PhaseType.before, frozen: false, durationSeconds: 300,
                    startTimeSeconds: nil, relativeTimeSeconds: nil, preparedBy: nil,
                    websiteUrl: nil, descr1ption: nil, difficulty: nil, kind: nil, icpcRegion: nil,
                    country: nil, city: nil, season: "season"),
            Contest(id: 72, name: "name7", type: ContestType.internationalOlympiadInInformatics,
                    phase: PhaseType.finished, frozen: true, durationSeconds: 300,
                    startTimeSeconds: nil, relativeTimeSeconds: nil, preparedBy: nil,
                    websiteUrl: nil, descr1ption: nil, difficulty: nil, kind: nil, icpcRegion: nil,
                    country: nil, city: "Novosibirsk", season: "season")
        ]
        
        let resultAdd = realmService.addContestList(
            contests, withRequestParams: ContestListRequest(gym: true))
        if case Result.error(let error) = resultAdd {
            XCTFail("Result.error(\(error))")
        }
        
        let resultGet = realmService.getContestList(
            withRequestParams: ContestListRequest(gym: true))
        switch resultGet {
        case .success(let list):
            XCTAssert(list.count == contests.count)
            for (i, contest) in list.enumerated() {
                XCTAssert(
                    contest.id == contests[i].id
                &&  contest.name == contests[i].name
                &&  contest.type == contests[i].type
                &&  contest.phase == contests[i].phase
                &&  contest.frozen == contests[i].frozen
                &&  contest.durationSeconds == contests[i].durationSeconds
                &&  contest.startTimeSeconds == contests[i].startTimeSeconds
                &&  contest.relativeTimeSeconds == contests[i].relativeTimeSeconds
                &&  contest.preparedBy == contests[i].preparedBy
                &&  contest.websiteUrl == contests[i].websiteUrl
                &&  contest.descr1ption == contests[i].descr1ption
                &&  contest.difficulty == contests[i].difficulty
                &&  contest.kind == contests[i].kind
                &&  contest.icpcRegion == contests[i].icpcRegion
                &&  contest.country == contests[i].country
                &&  contest.city == contests[i].city
                &&  contest.season == contests[i].season
                )
            }
        case .error(let error):
            XCTFail("Error occured: \(error)")
        }
    }
    
    
    func testRealmProblemSetProblems() {
        let problems = [
            Problem(contestId: 34, problemsetName: nil, index: "A", name: "test fails",
                    type: ProblemType.programming, points: nil, tags: []),
            Problem(contestId: 44, problemsetName: nil, index: "B", name: "all tests fails",
                    type: ProblemType.programming, points: nil, tags: []),
            Problem(contestId: 44, problemsetName: nil, index: "C", name: "some tests fails",
                    type: ProblemType.question, points: 555, tags: []),
            Problem(contestId: 44, problemsetName: "pSName", index: "D", name: "no test fails",
                    type: ProblemType.programming, points: nil, tags: []),
            Problem(contestId: nil, problemsetName: nil, index: "E", name: "just no tests",
                    type: ProblemType.question, points: nil, tags: [])
        ]
        
        let problemStatistics = [
            ProblemStatistics(contestId: 34, index: "A", solvedCount: 5),
            ProblemStatistics(contestId: 44, index: "B", solvedCount: 2),
            ProblemStatistics(contestId: 44, index: "C", solvedCount: 3),
            ProblemStatistics(contestId: 44, index: "D", solvedCount: 4),
            ProblemStatistics(contestId: nil, index: "E", solvedCount: 5)
        ]
        
        let problemSetProblems = ProblemSetProblems(
            problems: problems, problemStatistics: problemStatistics)
        
        let resultAdd = realmService.addProblemSetProblems(problemSetProblems)
        
        if case Result.error(let error) = resultAdd {
            XCTFail("Error occured: \(error)")
        }
        
        let resultGet = realmService.getProblemSetProblems()
        switch resultGet {
        case .success(let problemSet):
            //check [Problem] first
            XCTAssert(problemSet.problems.count == problems.count)
            for (i, problem) in problemSet.problems.enumerated() {
                XCTAssert((
                    problem.contestId == problems[i].contestId
                &&  problem.index == problems[i].index
                &&  problem.problemsetName == problems[i].problemsetName
                &&  problem.name == problems[i].name
                &&  problem.type == problems[i].type
                &&  problem.points == problems[i].points
                &&  problem.tags == problems[i].tags
                ))
            }
            //check [ProblemStatistics]
            XCTAssert(problemSet.problemStatistics.count == problemStatistics.count)
            for (i, stat) in problemSet.problemStatistics.enumerated() {
                XCTAssert((
                    stat.contestId == problemStatistics[i].contestId
                &&  stat.index == problemStatistics[i].index
                &&  stat.solvedCount == problemStatistics[i].solvedCount
                ))
            }
        case .error(let error):
            XCTFail("Error occured: \(error)")
        }
    }
}
