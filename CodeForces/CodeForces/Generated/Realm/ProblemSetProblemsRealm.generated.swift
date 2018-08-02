// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class ProblemSetProblemsRealm: Object { 
    
    var problems = List<ProblemRealm>()    
    var problemStatistics = List<ProblemStatisticsRealm>()

    func getRealmId() -> Int {
        return "\(problems.customHash)\(problemStatistics.customHash)".hash
    }

    @objc dynamic var realmId: Int = 0

    override static func primaryKey() -> String? {
        return "realmId"
    }
    
}

extension ProblemSetProblemsRealm: RealmObject {
    var model: ProblemSetProblems {
        
        
        
        return ProblemSetProblems(problems: problems.array, problemStatistics: problemStatistics.array)
    }

    convenience init(model: ProblemSetProblems) {
        self.init()
        
        self.problems = model.problems.realmList        
        self.problemStatistics = model.problemStatistics.realmList        
    }
}

extension ProblemSetProblems: RealmRepresentable {
    var persistenceObject: ProblemSetProblemsRealm {
        return ProblemSetProblemsRealm(model: self)
    }
}
