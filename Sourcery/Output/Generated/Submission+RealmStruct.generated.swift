// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class SubmissionObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var contestId: Int? = nil
    @objc dynamic var creationTimeSeconds: Int = 0
    @objc dynamic var relativeTimeSeconds: Int = 0
    @objc dynamic var problem: Problem = completeRealmExpression
    @objc dynamic var author: Party = completeRealmExpression
    @objc dynamic var programmingLanguage: String = ""
    @objc dynamic var verdict: SubmissionVerdict? = nil
    @objc dynamic var testset: TestSet = completeRealmExpression
    @objc dynamic var passedTestCount: Int = 0
    @objc dynamic var timeConsumedMillis: Int = 0
    @objc dynamic var memoryConsumedBytes: Int = 0
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension Submission: RealmRepresentable {
    var realmObject: SubmissionObject {
        let submission = SubmissionObject()
        submission.id = id
        submission.contestId = contestId
        submission.creationTimeSeconds = creationTimeSeconds
        submission.relativeTimeSeconds = relativeTimeSeconds
        submission.problem = problem
        submission.author = author
        submission.programmingLanguage = programmingLanguage
        submission.verdict = verdict
        submission.testset = testset
        submission.passedTestCount = passedTestCount
        submission.timeConsumedMillis = timeConsumedMillis
        submission.memoryConsumedBytes = memoryConsumedBytes
        return submission
    }
}
extension SubmissionObject: StructRepresentable {
    var `struct`: Submission {
        return Submission(id: id, contestId: contestId, creationTimeSeconds: creationTimeSeconds, relativeTimeSeconds: relativeTimeSeconds, problem: problem, author: author, programmingLanguage: programmingLanguage, verdict: verdict, testset: testset, passedTestCount: passedTestCount, timeConsumedMillis: timeConsumedMillis, memoryConsumedBytes: memoryConsumedBytes)
    }
}
