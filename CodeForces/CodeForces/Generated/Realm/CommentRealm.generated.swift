// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class CommentRealm: Object { 

    @objc dynamic var id: Int = 0 
    @objc dynamic var creationTimeSeconds: Int = 0 
    @objc dynamic var commentatorHandle: String = "" 
    @objc dynamic var locale: String = "" 
    @objc dynamic var text: String = ""  
    let parentCommentId = RealmOptional<Int>() 
    @objc dynamic var rating: Int = 0 

    override static func primaryKey() -> String? {
        return "id"
    }
    
}

extension CommentRealm: RealmObject {
    var model: Comment {
        
        
        
        return Comment(id: id, creationTimeSeconds: creationTimeSeconds, commentatorHandle: commentatorHandle, locale: locale, text: text, parentCommentId: parentCommentId.value, rating: rating)
    }

    convenience init(model: Comment) {
        self.init()
        
        self.id = model.id        
        self.creationTimeSeconds = model.creationTimeSeconds        
        self.commentatorHandle = model.commentatorHandle        
        self.locale = model.locale        
        self.text = model.text        
        self.parentCommentId.value = model.parentCommentId        
        self.rating = model.rating        
    }
}

extension Comment: RealmRepresentable {
    var persistenceObject: CommentRealm {
        return CommentRealm(model: self)
    }
}
