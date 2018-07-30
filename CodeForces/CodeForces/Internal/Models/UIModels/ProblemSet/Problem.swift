import Foundation

//sourcery: RealmStruct
struct Problem: Codable {
    let contestId: Int?
    let problemsetName: String?
    let index: String //Letter, may be followed by a digit; problem index in a contest.
    let name: String
    let type: ProblemType
    let points: Float?
    let tags: [String] //problem tags
    
}
