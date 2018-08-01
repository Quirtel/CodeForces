import Foundation

struct ProblemSetRecentStatusRequest: Codable {
    let count: Int
    let problemsetName: String?
    
    init(count: Int, problemsetName: String? = nil) {
        self.count = count
        self.problemsetName = problemsetName
    }
}
