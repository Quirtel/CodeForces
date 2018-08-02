// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class MemberRealm: Object { 

    @objc dynamic var handle: String = "" 

    

}

extension MemberRealm: RealmObject {
    var model: Member {
        
        
        
        return Member(handle: handle)
    }

    convenience init(model: Member) {
        self.init()
        
        self.handle = model.handle        
    }
}

extension Member: RealmRepresentable {
    var persistenceObject: MemberRealm {
        return MemberRealm(model: self)
    }
}
