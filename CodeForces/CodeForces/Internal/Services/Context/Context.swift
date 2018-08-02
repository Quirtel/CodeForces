import Foundation

protocol Contextual {
    var context: Context? { get set }
}

// 'ServiceLocator' pattern
class Context {
    let preferences: Preferences
    let contentService: ContentService

    private init(
            preferences: Preferences,
            contentService: ContentService) {
        self.preferences = preferences
        self.contentService = contentService
    }
}

extension Context {
    
    static func createContext() -> Context? {
        let context = Context(preferences: Preferences(), contentService: ContentService())
        return context
    }
}

