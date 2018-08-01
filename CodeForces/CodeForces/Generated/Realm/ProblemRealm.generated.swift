// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class ProblemRealm: Object { 
 
    let contestId = RealmOptional<Int>() 
    @objc dynamic var problemsetName: String? = nil 
    @objc dynamic var index: String = "" 
    @objc dynamic var name: String = "" 
    @objc dynamic var type: String!  
    let points = RealmOptional<Float>()     
    var tags = List<String>()

}

extension ProblemRealm: RealmObject {
    var model: Problem {
        guard let typeValue = type, let type = ProblemType(rawValue: typeValue) else {
            fatalError("Enum case not found")
        }
        
        
        return Problem(contestId: contestId.value, problemsetName: problemsetName, index: index, name: name, type: type, points: points.value, tags: tags.array)
    }

    convenience init(model: Problem) {
        self.init()
        
        self.contestId.value = model.contestId        
        self.problemsetName = model.problemsetName        
        self.index = model.index        
        self.name = model.name        
        self.type = model.type.rawValue        
        self.points.value = model.points        
        self.tags = model.tags.realmList        
    }
}

extension Problem: RealmRepresentable {
    var persistenceObject: ProblemRealm {
        return ProblemRealm(model: self)
    }
}
