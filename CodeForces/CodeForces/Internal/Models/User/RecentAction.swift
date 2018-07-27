import Foundation

struct RecentAction: Codable {
    let timeSeconds: Int
    let blogEntry: BlogEntry? //only in short form (see BlogEntry.swift)
    let comment: Comment?
}
