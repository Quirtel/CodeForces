import Foundation

protocol Contextual {
    var context: Context? { get }
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
        
        ThemeManager.applyTheme(theme: preferences.selectedTheme)
        subscribeOnThemeChange()
    }
    
    private func subscribeOnThemeChange() {
        NotificationCenter.default.addObserver(
        forName: .preferencesChangeTheme, object: nil, queue: nil) { [weak self] _ in
            if let theme =  self?.preferences.selectedTheme {
                ThemeManager.applyTheme(theme: theme)
            }
        }
    }
}

extension Context {
    
    static func createContext() -> Context? {
        let preferences = Preferences()
        let context = Context(preferences: preferences, contentService: ContentService())
        return context
    }
}

