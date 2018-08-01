// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class RecentActionRealm: Object { 

    @objc dynamic var timeSeconds: Int = 0 
    @objc dynamic var blogEntry: BlogEntryRealm? = nil 
    @objc dynamic var comment: CommentRealm? = nil 

}

extension RecentActionRealm: RealmObject {
    var model: RecentAction {
        
        
        
        return RecentAction(timeSeconds: timeSeconds, blogEntry: blogEntry?.model, comment: comment?.model)
    }

    convenience init(model: RecentAction) {
        self.init()
        
        self.timeSeconds = model.timeSeconds        
        self.blogEntry = model.blogEntry?.persistenceObject        
        self.comment = model.comment?.persistenceObject        
    }
}

extension RecentAction: RealmRepresentable {
    var persistenceObject: RecentActionRealm {
        return RecentActionRealm(model: self)
    }
}
