import Foundation

//sourcery: RealmPersistable
struct ProblemStatistics: Codable {
    let contestId: Int?
    let index: String //Letter, may be followed by a digit; problem index in a contest.
    let solvedCount: Int //Number of users who solved the problem
}
