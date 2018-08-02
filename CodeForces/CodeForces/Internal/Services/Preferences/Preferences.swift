import Foundation
import SwiftyUserDefaults


class Preferences {
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
