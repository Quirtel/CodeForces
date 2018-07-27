import Foundation

struct ProblemResult: Codable {
    let points: Float
    let penalty: Int
    let rejectedAttemptCount: Int
    let type: ProblemResultType
    let bestSubmissionTimeSeconds: Int
}
