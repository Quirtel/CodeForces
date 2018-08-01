import Foundation

struct ProblemSetProblemsRequest: Codable {
    let tags: [String]?
    let problemsetName: String?
    
    init(tags: [String]? = nil, problemsetName: String? = nil) {
        self.tags = tags
        self.problemsetName = problemsetName
    }
}

//sourcery: RealmPersistable
struct ProblemSetProblems: Codable {
    let problems: [Problem]
    let problemStatistics: [ProblemStatistics]
}
