import Foundation

struct ContestStatusRequest: Codable {
    let contestId: Int
    let handle: String?
    let from: Int?
    let count: Int?
}
