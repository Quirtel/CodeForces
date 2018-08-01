// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class ContestStandingsRealm: Object { 

    @objc dynamic var contest: ContestRealm!     
    var problems = List<ProblemRealm>()    
    var rows = List<RanklistRowRealm>()

}

extension ContestStandingsRealm: RealmObject {
    var model: ContestStandings {
        
        
        
        return ContestStandings(contest: contest.model, problems: problems.array, rows: rows.array)
    }

    convenience init(model: ContestStandings) {
        self.init()
        
        self.contest = model.contest.persistenceObject        
        self.problems = model.problems.realmList        
        self.rows = model.rows.realmList        
    }
}

extension ContestStandings: RealmRepresentable {
    var persistenceObject: ContestStandingsRealm {
        return ContestStandingsRealm(model: self)
    }
}
