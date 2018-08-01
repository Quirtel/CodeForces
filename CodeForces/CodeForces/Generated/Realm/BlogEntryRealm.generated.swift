// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class BlogEntryRealm: Object { 

    @objc dynamic var id: Int = 0 // Int(id)
    @objc dynamic var originalLocale: String = "" // ""
    @objc dynamic var creationTimeSeconds: Int = 0 // Int(creationTimeSeconds)
    @objc dynamic var authorHandle: String = "" // ""
    @objc dynamic var title: String = "" // ""
    @objc dynamic var content: String? = nil // content ?? ""
    @objc dynamic var locale: String = "" // ""
    @objc dynamic var modificationTimeSeconds: Int = 0 // Int(modificationTimeSeconds)
    @objc dynamic var allowViewHistory: Bool = false // ""    
    var tags = List<String>()// tags.customHash
    @objc dynamic var rating: Int = 0 // Int(rating)

    
        override static func primaryKey() -> String? {
            return "id"
        }
        

}

extension BlogEntryRealm: RealmObject {
    var model: BlogEntry {
        
        
        
        return BlogEntry(id: id, originalLocale: originalLocale, creationTimeSeconds: creationTimeSeconds, authorHandle: authorHandle, title: title, content: content, locale: locale, modificationTimeSeconds: modificationTimeSeconds, allowViewHistory: allowViewHistory, tags: tags.array, rating: rating)
    }

    convenience init(model: BlogEntry) {
        self.init()
        
        self.id = model.id        
        self.originalLocale = model.originalLocale        
        self.creationTimeSeconds = model.creationTimeSeconds        
        self.authorHandle = model.authorHandle        
        self.title = model.title        
        self.content = model.content        
        self.locale = model.locale        
        self.modificationTimeSeconds = model.modificationTimeSeconds        
        self.allowViewHistory = model.allowViewHistory        
        self.tags = model.tags.realmList        
        self.rating = model.rating        
    }
}

extension BlogEntry: RealmRepresentable {
    var persistenceObject: BlogEntryRealm {
        return BlogEntryRealm(model: self)
    }
}
