import Foundation
import UIKit



enum Theme: Int {
    case light
    case dark
    
    var mainColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("289bff")
        case .dark:
            return .colorFromHexString("1d2a39")
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("ffffff")
        case .dark:
            return .colorFromHexString("1d2a39")
        }
    }
    
    var cellColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("ffffff")
        case .dark:
            return .colorFromHexString("171f27")
        }
    }
    
    var barStyle: UIBarStyle {
        switch self {
        case .light:
            return .default
        case .dark:
            return .black
        }
    }
    
    // NavigationBar
    
    var navigationBarBarTintColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("ffffff")
        case .dark:
            return .colorFromHexString("1d2a39")
        }
    }
    
    var navigationBarTintColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("000000")
        case .dark:
            return .colorFromHexString("ffffff")
        }
    }
    
    //TabBar
    
    var tapBarTintColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("289bff")
        case .dark:
            return .colorFromHexString("289bff")
        }
    }
    
    var tapBarBarTintColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("ffffff")
        case .dark:
            return .colorFromHexString("1d2a39")
        }
    }
    
    // Cell
    
    var cellTitleColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("000000")
        case .dark:
            return .colorFromHexString("ffffff")
        }
    }
    
    var cellTextColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("5b6a74")
        case .dark:
            return .colorFromHexString("5b6a74")
        }
    }
    
    var tagsColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("289bff")
        case .dark:
            return .colorFromHexString("289bff")
        }
    }
}

class ThemeManager {
    
    private let preferences: Preferences
    var currentTheme: Theme {
        return preferences.selectedTheme
    }
    
    init(preferences: Preferences) {
        self.preferences = preferences
        applyTheme(theme: preferences.selectedTheme)
    }
    
    func applyTheme(theme: Theme) {
        preferences.selectedTheme = theme
        
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.mainColor
        
        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().barTintColor = theme.navigationBarBarTintColor
        UINavigationBar.appearance().tintColor = theme.navigationBarTintColor
        
        UITabBar.appearance().tintColor = theme.tapBarTintColor
        UITabBar.appearance().barTintColor = theme.tapBarBarTintColor


    }
}


