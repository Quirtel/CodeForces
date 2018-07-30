// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class RecentActionObject: Object {
    @objc dynamic var timeSeconds: Int = 0
    @objc dynamic var blogEntry: BlogEntry? = nil
    @objc dynamic var comment: Comment? = nil
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension RecentAction: RealmRepresentable {
    var realmObject: RecentActionObject {
        let recentAction = RecentActionObject()
        recentAction.timeSeconds = timeSeconds
        recentAction.blogEntry = blogEntry
        recentAction.comment = comment
        return recentAction
    }
}
extension RecentActionObject: StructRepresentable {
    var `struct`: RecentAction {
        return RecentAction(timeSeconds: timeSeconds, blogEntry: blogEntry, comment: comment)
    }
}
