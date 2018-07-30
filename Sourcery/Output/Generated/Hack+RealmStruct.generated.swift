// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class HackObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var creationTimeSeconds: Int = 0
    @objc dynamic var hacker: Party = completeRealmExpression
    @objc dynamic var defender: Party = completeRealmExpression
    @objc dynamic var verdict: HackVerdict? = nil
    @objc dynamic var problem: Problem = completeRealmExpression
    @objc dynamic var test: String? = nil
    @objc dynamic var judgeProtocol: JudgeProtocol? = nil
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension Hack: RealmRepresentable {
    var realmObject: HackObject {
        let hack = HackObject()
        hack.id = id
        hack.creationTimeSeconds = creationTimeSeconds
        hack.hacker = hacker
        hack.defender = defender
        hack.verdict = verdict
        hack.problem = problem
        hack.test = test
        hack.judgeProtocol = judgeProtocol
        return hack
    }
}
extension HackObject: StructRepresentable {
    var `struct`: Hack {
        return Hack(id: id, creationTimeSeconds: creationTimeSeconds, hacker: hacker, defender: defender, verdict: verdict, problem: problem, test: test, judgeProtocol: judgeProtocol)
    }
}
