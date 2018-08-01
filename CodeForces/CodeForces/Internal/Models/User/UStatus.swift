import Foundation

struct UserStatusRequest: Codable {
    let handle: String
    let from: Int?
    let count: Int?
}
