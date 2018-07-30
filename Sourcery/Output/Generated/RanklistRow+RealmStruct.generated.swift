// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class RanklistRowObject: Object {
    @objc dynamic var party: Party = completeRealmExpression
    @objc dynamic var rank: Int = 0
    @objc dynamic var points: Float = completeRealmExpression
    @objc dynamic var penalty: Int = 0
    @objc dynamic var successfulHackCount: Int = 0
    @objc dynamic var unsuccessfulHackCount: Int = 0
    @objc dynamic var problemResults: [ProblemResult] = completeRealmExpression
    @objc dynamic var lastSubmissionTimeSeconds: Int? = nil
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension RanklistRow: RealmRepresentable {
    var realmObject: RanklistRowObject {
        let ranklistRow = RanklistRowObject()
        ranklistRow.party = party
        ranklistRow.rank = rank
        ranklistRow.points = points
        ranklistRow.penalty = penalty
        ranklistRow.successfulHackCount = successfulHackCount
        ranklistRow.unsuccessfulHackCount = unsuccessfulHackCount
        ranklistRow.problemResults = problemResults
        ranklistRow.lastSubmissionTimeSeconds = lastSubmissionTimeSeconds
        return ranklistRow
    }
}
extension RanklistRowObject: StructRepresentable {
    var `struct`: RanklistRow {
        return RanklistRow(party: party, rank: rank, points: points, penalty: penalty, successfulHackCount: successfulHackCount, unsuccessfulHackCount: unsuccessfulHackCount, problemResults: problemResults, lastSubmissionTimeSeconds: lastSubmissionTimeSeconds)
    }
}
