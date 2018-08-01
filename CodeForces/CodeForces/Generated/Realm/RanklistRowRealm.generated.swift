// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class RanklistRowRealm: Object { 

    @objc dynamic var party: PartyRealm! // ""
    @objc dynamic var rank: Int = 0 // Int(rank)
    @objc dynamic var points: Float = 0 // Int(points)
    @objc dynamic var penalty: Int = 0 // Int(penalty)
    @objc dynamic var successfulHackCount: Int = 0 // Int(successfulHackCount)
    @objc dynamic var unsuccessfulHackCount: Int = 0 // Int(unsuccessfulHackCount)    
    var problemResults = List<ProblemResultRealm>()// problemResults.customHash 
    let lastSubmissionTimeSeconds = RealmOptional<Int>() // lastSubmissionTimeSeconds.value ?? 0

    

}

extension RanklistRowRealm: RealmObject {
    var model: RanklistRow {
        
        
        
        return RanklistRow(party: party.model, rank: rank, points: points, penalty: penalty, successfulHackCount: successfulHackCount, unsuccessfulHackCount: unsuccessfulHackCount, problemResults: problemResults.array, lastSubmissionTimeSeconds: lastSubmissionTimeSeconds.value)
    }

    convenience init(model: RanklistRow) {
        self.init()
        
        self.party = model.party.persistenceObject        
        self.rank = model.rank        
        self.points = model.points        
        self.penalty = model.penalty        
        self.successfulHackCount = model.successfulHackCount        
        self.unsuccessfulHackCount = model.unsuccessfulHackCount        
        self.problemResults = model.problemResults.realmList        
        self.lastSubmissionTimeSeconds.value = model.lastSubmissionTimeSeconds        
    }
}

extension RanklistRow: RealmRepresentable {
    var persistenceObject: RanklistRowRealm {
        return RanklistRowRealm(model: self)
    }
}
