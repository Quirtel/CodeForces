import Foundation

struct ProblemSetRecentStatusRequest: Codable {
    let count: Int
    let problemsetName: String?
}
