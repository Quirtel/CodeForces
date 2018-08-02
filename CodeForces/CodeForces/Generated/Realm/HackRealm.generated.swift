// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class HackRealm: Object { 

    @objc dynamic var id: Int = 0 
    @objc dynamic var creationTimeSeconds: Int = 0 
    @objc dynamic var hacker: PartyRealm! 
    @objc dynamic var defender: PartyRealm! 
    @objc dynamic var verdict: String?
    @objc dynamic var problem: ProblemRealm! 
    @objc dynamic var test: String? = nil 
    @objc dynamic var judgeProtocol: JudgeProtocolRealm? = nil 

    
        override static func primaryKey() -> String? {
            return "id"
        }
        

}

extension HackRealm: RealmObject {
    var model: Hack {
        
        let verdict = self.verdict.flatMap { HackVerdict(rawValue: $0) }
        
        return Hack(id: id, creationTimeSeconds: creationTimeSeconds, hacker: hacker.model, defender: defender.model, verdict: verdict, problem: problem.model, test: test, judgeProtocol: judgeProtocol?.model)
    }

    convenience init(model: Hack) {
        self.init()
        
        self.id = model.id        
        self.creationTimeSeconds = model.creationTimeSeconds        
        self.hacker = model.hacker.persistenceObject        
        self.defender = model.defender.persistenceObject        
        self.verdict = model.verdict?.rawValue        
        self.problem = model.problem.persistenceObject        
        self.test = model.test        
        self.judgeProtocol = model.judgeProtocol?.persistenceObject        
    }
}

extension Hack: RealmRepresentable {
    var persistenceObject: HackRealm {
        return HackRealm(model: self)
    }
}
