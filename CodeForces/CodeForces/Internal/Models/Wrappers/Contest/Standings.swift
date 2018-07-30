import Foundation

struct ContestStandingsRequest: Codable {
    let contestId: Int
    let from: Int?
    let count: Int?
    let handles: [String]?
    let room: Int?
    let showUnofficial: Bool
}

struct ContestStandings: Codable {
    let contest: Contest
    let problems: [Problem]
    let rows: [RanklistRow]
}
