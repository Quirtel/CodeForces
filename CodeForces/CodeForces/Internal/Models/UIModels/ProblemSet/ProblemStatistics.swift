import Foundation

//sourcery: RealmPersistable, NeedRealmId
struct ProblemStatistics: Codable {
    //vbnmvbnmvsourcery: Hashsource
    let contestId: Int?
    //sourcery: Hashsource
    let index: String //Letter, may be followed by a digit; problem index in a contest.
    let solvedCount: Int //Number of users who solved the problem
}
