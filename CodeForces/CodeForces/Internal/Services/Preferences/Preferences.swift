import Foundation
import SwiftyUserDefaults


extension Notification.Name {
    static let preferencesChangeTheme = Notification.Name("CFPreferencesChangeThemeNotofication")
}

class Preferences {
    private static let lastUpdatedDateKey: String = "UpdatedDate"

    private let settings = Defaults
    
    var lastUpdated: Date {
        set {
            settings[.updatedDate] = newValue
        }
        get {
            return settings[.updatedDate]
        }
    }
    
    var selectedTheme: Theme {
        set {
            settings[.selectedThemeKey] = newValue.rawValue
            NotificationCenter.default.post(name: .preferencesChangeTheme, object: newValue)
        }
        get {
            if let theme = Theme(rawValue: settings[.selectedThemeKey]) {
                return theme
            }
            return .light
        }
    }
    
    var selectedCacheTime: CacheTime {
        set {
            settings[.cacheTimeKey] = newValue.rawValue
        }
        get {
            if let cacheTime = CacheTime(rawValue: settings[.cacheTimeKey]) {
                return cacheTime
            }
            return .never
        }
    }
}
