import Foundation

struct Comment: Codable {
    let id: Int
    let creationTimeSeconds: Int
    let commentatorHandle: String
    let locale: String
    let text: String
    let parentCommentId: Int?
    let rating: Int
}
