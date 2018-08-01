// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class ProblemResultRealm: Object { 

    @objc dynamic var points: Float = 0 // Int(points) 
    let penalty = RealmOptional<Int>() // penalty.value ?? 0
    @objc dynamic var rejectedAttemptCount: Int = 0 // Int(rejectedAttemptCount)
    @objc dynamic var type: String! // type 
    let bestSubmissionTimeSeconds = RealmOptional<Int>() // bestSubmissionTimeSeconds.value ?? 0

    

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
