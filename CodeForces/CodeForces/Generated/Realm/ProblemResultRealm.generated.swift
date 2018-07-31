// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class ProblemResultRealm: Object { 

    @objc dynamic var points: Float = 0  
    let penalty = RealmOptional<Int>() 
    @objc dynamic var rejectedAttemptCount: Int = 0 
    @objc dynamic var type: String!  
    let bestSubmissionTimeSeconds = RealmOptional<Int>() 

}

extension ProblemResultRealm: RealmObject {
    var model: ProblemResult {
        guard let typeValue = type, let type = ProblemResultType(rawValue: typeValue) else {
            fatalError("Enum case not found")
        }
        
        
        return ProblemResult(points: points, penalty: penalty.value, rejectedAttemptCount: rejectedAttemptCount, type: type, bestSubmissionTimeSeconds: bestSubmissionTimeSeconds.value)
    }

    convenience init(model: ProblemResult) {
        self.init()
        
        self.points = model.points        
        self.penalty.value = model.penalty        
        self.rejectedAttemptCount = model.rejectedAttemptCount        
        self.type = model.type.rawValue        
        self.bestSubmissionTimeSeconds.value = model.bestSubmissionTimeSeconds        
    }
}

extension ProblemResult: RealmRepresentable {
    var persistenceObject: ProblemResultRealm {
        return ProblemResultRealm(model: self)
    }
}
