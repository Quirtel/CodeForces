import Foundation

struct ContestStandingsRequest: Codable {
    let contestId: Int
    let from: Int?
    let count: Int?
    let handles: [String]?
    let room: Int?
    let showUnofficial: Bool
    
    init(
        contestId: Int, from: Int? = nil, count: Int? = nil,
        handles: [String]? = nil, room: Int? = nil, showUnofficial: Bool = false) {
        self.contestId = contestId
        self.from = from
        self.count = count
        self.handles = handles
        self.room = room
        self.showUnofficial = showUnofficial
    }
}

//sourcery: RealmPersistable
struct ContestStandings: Codable {
    let contest: Contest
    let problems: [Problem]
    let rows: [RanklistRow]
}
