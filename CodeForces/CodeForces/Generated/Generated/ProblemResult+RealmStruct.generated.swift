// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class ProblemResultObject: Object {
    @objc dynamic var points: Float = 0
    let penalty = RealmOptional<Int>()
    @objc dynamic var rejectedAttemptCount: Int = 0
    @objc dynamic var type: ProblemResultType = completeRealmExpression
    let bestSubmissionTimeSeconds = RealmOptional<Int>()
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension ProblemResult: RealmRepresentable {
    var realmObject: ProblemResultObject {
        let problemResult = ProblemResultObject()
        problemResult.points = points
        problemResult.penalty.value = penalty
        problemResult.rejectedAttemptCount = rejectedAttemptCount
        problemResult.type = type
        problemResult.bestSubmissionTimeSeconds.value = bestSubmissionTimeSeconds
        return problemResult
    }
}
extension ProblemResultObject: StructRepresentable {
    var `struct`: ProblemResult {
        return ProblemResult(points: points, penalty: penalty.value, rejectedAttemptCount: rejectedAttemptCount, type: type, bestSubmissionTimeSeconds: bestSubmissionTimeSeconds.value)
    }
}
