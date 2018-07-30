// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class ProblemObject: Object {
    @objc dynamic var contestId: Int? = nil
    @objc dynamic var problemsetName: String? = nil
    @objc dynamic var index: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var type: ProblemType = completeRealmExpression
    @objc dynamic var points: Float? = nil
    @objc dynamic var tags: [String] = completeRealmExpression
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension Problem: RealmRepresentable {
    var realmObject: ProblemObject {
        let problem = ProblemObject()
        problem.contestId = contestId
        problem.problemsetName = problemsetName
        problem.index = index
        problem.name = name
        problem.type = type
        problem.points = points
        problem.tags = tags
        return problem
    }
}
extension ProblemObject: StructRepresentable {
    var `struct`: Problem {
        return Problem(contestId: contestId, problemsetName: problemsetName, index: index, name: name, type: type, points: points, tags: tags)
    }
}
