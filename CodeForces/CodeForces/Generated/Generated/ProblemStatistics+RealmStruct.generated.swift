// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class ProblemStatisticsObject: Object {
    let contestId = RealmOptional<Int>()
    @objc dynamic var index: String = ""
    @objc dynamic var solvedCount: Int = 0
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension ProblemStatistics: RealmRepresentable {
    var realmObject: ProblemStatisticsObject {
        let problemStatistics = ProblemStatisticsObject()
        problemStatistics.contestId.value = contestId
        problemStatistics.index = index
        problemStatistics.solvedCount = solvedCount
        return problemStatistics
    }
}
extension ProblemStatisticsObject: StructRepresentable {
    var `struct`: ProblemStatistics {
        return ProblemStatistics(contestId: contestId.value, index: index, solvedCount: solvedCount)
    }
}
