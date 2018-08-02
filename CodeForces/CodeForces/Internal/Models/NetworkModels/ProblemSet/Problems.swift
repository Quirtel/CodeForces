import Foundation

struct ProblemSetProblemsRequest: Codable {
    let tags: [String]?
    let problemsetName: String?
    
    init(tags: [String]? = nil, problemsetName: String? = nil) {
        self.tags = tags
        self.problemsetName = problemsetName
    }
}

//sourcery: RealmPersistable, NeedRealmId
struct ProblemSetProblems: Codable {
    //sourcery: Hashsource
    let problems: [Problem]
    //sourcery: Hashsource
    let problemStatistics: [ProblemStatistics]
}
