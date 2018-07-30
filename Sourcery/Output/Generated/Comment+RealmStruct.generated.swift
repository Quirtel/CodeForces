// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class CommentObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var creationTimeSeconds: Int = 0
    @objc dynamic var commentatorHandle: String = ""
    @objc dynamic var locale: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var parentCommentId: Int? = nil
    @objc dynamic var rating: Int = 0
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension Comment: RealmRepresentable {
    var realmObject: CommentObject {
        let comment = CommentObject()
        comment.id = id
        comment.creationTimeSeconds = creationTimeSeconds
        comment.commentatorHandle = commentatorHandle
        comment.locale = locale
        comment.text = text
        comment.parentCommentId = parentCommentId
        comment.rating = rating
        return comment
    }
}
extension CommentObject: StructRepresentable {
    var `struct`: Comment {
        return Comment(id: id, creationTimeSeconds: creationTimeSeconds, commentatorHandle: commentatorHandle, locale: locale, text: text, parentCommentId: parentCommentId, rating: rating)
    }
}
