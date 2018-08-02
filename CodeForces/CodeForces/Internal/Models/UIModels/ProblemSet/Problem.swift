import Foundation

//sourcery: RealmPersistable, NeedRealmId
struct Problem: Codable {
    //sourcery: Hashsource
    let contestId: Int?
    //sourcery: Hashsource
    let problemsetName: String?
    //sourcery: Hashsource
    let index: String //Letter, may be followed by a digit; problem index in a contest.
    //sourcery: Hashsource
    let name: String
    let type: ProblemType
    let points: Float?
    let tags: [String] //problem tags
}
