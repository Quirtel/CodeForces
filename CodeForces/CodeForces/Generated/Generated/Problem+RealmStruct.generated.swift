// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class ProblemObject: Object {
    let contestId = RealmOptional<Int>()
    @objc dynamic var problemsetName: String? = nil
    @objc dynamic var index: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var type: ProblemType = completeRealmExpression
    let points = RealmOptional<Float>()
    @objc dynamic var tags: [String] = []
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension Problem: RealmRepresentable {
    var realmObject: ProblemObject {
        let problem = ProblemObject()
        problem.contestId.value = contestId
        problem.problemsetName = problemsetName
        problem.index = index
        problem.name = name
        problem.type = type
        problem.points.value = points
        problem.tags = tags
        return problem
    }
}
extension ProblemObject: StructRepresentable {
    var `struct`: Problem {
        return Problem(contestId: contestId.value, problemsetName: problemsetName, index: index, name: name, type: type, points: points.value, tags: tags)
    }
}
