// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class BlogEntryObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var originalLocale: String = ""
    @objc dynamic var creationTimeSeconds: Int = 0
    @objc dynamic var authorHandle: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var content: String? = nil
    @objc dynamic var locale: String = ""
    @objc dynamic var modificationTimeSeconds: Int = 0
    @objc dynamic var allowViewHistory: Bool = false
    @objc dynamic var tags: [String] = []
    @objc dynamic var rating: Int = 0
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension BlogEntry: RealmRepresentable {
    var realmObject: BlogEntryObject {
        let blogEntry = BlogEntryObject()
        blogEntry.id = id
        blogEntry.originalLocale = originalLocale
        blogEntry.creationTimeSeconds = creationTimeSeconds
        blogEntry.authorHandle = authorHandle
        blogEntry.title = title
        blogEntry.content = content
        blogEntry.locale = locale
        blogEntry.modificationTimeSeconds = modificationTimeSeconds
        blogEntry.allowViewHistory = allowViewHistory
        blogEntry.tags = tags
        blogEntry.rating = rating
        return blogEntry
    }
}
extension BlogEntryObject: StructRepresentable {
    var `struct`: BlogEntry {
        return BlogEntry(id: id, originalLocale: originalLocale, creationTimeSeconds: creationTimeSeconds, authorHandle: authorHandle, title: title, content: content, locale: locale, modificationTimeSeconds: modificationTimeSeconds, allowViewHistory: allowViewHistory, tags: tags, rating: rating)
    }
}
