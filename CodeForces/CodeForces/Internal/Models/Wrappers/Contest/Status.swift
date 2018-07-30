import Foundation

struct ContestStatusRequest: Codable {
    let contestId: Int
    let handle: String?
    let from: Int?
    let count: Int?
    
    init(contestId: Int, handle: String? = nil, from: Int? = nil, count: Int? = nil) {
        self.contestId = contestId
        self.handle = handle
        self.from = from
        self.count = count
    }
}
