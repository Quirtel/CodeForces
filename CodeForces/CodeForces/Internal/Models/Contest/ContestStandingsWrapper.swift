import Foundation

struct ContestStandingsWrapper: Codable {
    let contest: Contest
    let problems: [Problem]
    let rows: [RanklistRow]
}
