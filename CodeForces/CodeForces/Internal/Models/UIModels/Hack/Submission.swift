import Foundation

//sourcery: RealmStruct
struct Submission: Codable {
    let id: Int
    let contestId: Int?
    let creationTimeSeconds: Int
    let relativeTimeSeconds: Int
    let problem: Problem
    let author: Party
    let programmingLanguage: String
    let verdict: SubmissionVerdict?
    let testset: TestSet
    let passedTestCount: Int
    let timeConsumedMillis: Int
    let memoryConsumedBytes: Int
}
