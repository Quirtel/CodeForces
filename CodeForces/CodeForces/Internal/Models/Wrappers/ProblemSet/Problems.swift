import Foundation

struct ProblemSetProblemsRequest: Codable {
    let tags: [String]?
    let problemsetName: String?
}

struct ProblemSetProblems: Codable {
    let problems: [Problem]
    let problemStatistics: [ProblemStatistics]
}
