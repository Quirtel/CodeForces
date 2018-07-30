import Foundation

struct BlogEntry: Codable {
    let id: Int
    let originalLocale: String
    let creationTimeSeconds: Int
    let authorHandle: String
    let title: String
    let content: String? //not included in short format
    let locale: String
    let modificationTimeSeconds: Int
    let allowViewHistory: Bool
    let tags: [String]
    let rating: Int
}
