import Foundation
import SwiftyUserDefaults


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
        }
        get {
            if let theme = Theme(rawValue: settings[.selectedThemeKey]) {
                return theme
            }
            return .light
        }
    }
}
