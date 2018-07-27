import Foundation

struct RanklistRow: Codable {
    let party: Party
    let rank: Int
    let points: Float
    let penalty: Int //total penalty of the party
    let successfulHackCount: Int
    let unsuccessfulHackCount: Int
    let problemResults: [ProblemResult]
    let lastSubmissionTimeSeconds: Int
}
