// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class JudgeProtocolRealm: Object { 

    @objc dynamic var manual: Bool = false // ""
    @objc dynamic var protocolDescription: String = "" // ""
    @objc dynamic var verdictDescription: String = "" // ""

    

}

extension JudgeProtocolRealm: RealmObject {
    var model: JudgeProtocol {
        
        
        
        return JudgeProtocol(manual: manual, protocolDescription: protocolDescription, verdictDescription: verdictDescription)
    }

    convenience init(model: JudgeProtocol) {
        self.init()
        
        self.manual = model.manual        
        self.protocolDescription = model.protocolDescription        
        self.verdictDescription = model.verdictDescription        
    }
}

extension JudgeProtocol: RealmRepresentable {
    var persistenceObject: JudgeProtocolRealm {
        return JudgeProtocolRealm(model: self)
    }
}
