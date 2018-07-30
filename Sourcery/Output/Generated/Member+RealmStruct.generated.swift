// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class MemberObject: Object {
    @objc dynamic var handle: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension Member: RealmRepresentable {
    var realmObject: MemberObject {
        let member = MemberObject()
        member.handle = handle
        return member
    }
}
extension MemberObject: StructRepresentable {
    var `struct`: Member {
        return Member(handle: handle)
    }
}
