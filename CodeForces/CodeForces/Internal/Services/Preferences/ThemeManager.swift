import Foundation
import UIKit



enum Theme: Int {
    case light
    case dark
    
    var index: Int {
        switch self {
        case .light:
            return 0
        case .dark:
            return 1

        }
    }
    
    init(index: Int) {
        switch index {
        case 0:
            self = .light
        case 1:
            self = .dark
        default:
            self = .dark
        }
    }
}

extension Theme {
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
            return .colorFromHexString("edecee")
        case .dark:
            return .colorFromHexString("161d23")
        }
    }
    
    var highlightedCellColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("cbcacc")
        case .dark:
            return .colorFromHexString("353f4b")
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
    
    var tabBarTintColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("289bff")
        case .dark:
            return .colorFromHexString("289bff")
        }
    }
    
    var tabBarBarTintColor: UIColor {
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
    
    var cellTintColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("289bff")
        case .dark:
            return .colorFromHexString("289bff")
        }
    }
    
    var separatorColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("cbcacc")
        case .dark:
            return .colorFromHexString("161c24")
        }
    }
    
    // Other
    
    var pointsColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("1d7f1d")
        case .dark:
            return .colorFromHexString("1d7f1d")
        }
    }
    
    var spinnerColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("cbcacc")
        case .dark:
            return .colorFromHexString("cbcacc")
        }
    }
    
    var selectedControlColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("5bb3ff")
        case .dark:
            return .colorFromHexString("5bb3ff")
        }
    }
}


class ThemeManager {
    
    static func applyTheme(theme: Theme) {
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.mainColor
        
        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().barTintColor = theme.navigationBarBarTintColor
        UINavigationBar.appearance().tintColor = theme.navigationBarTintColor
        

        UITabBar.appearance().tintColor = theme.tabBarTintColor
        UITabBar.appearance().barTintColor = theme.tabBarBarTintColor
        
        UITableViewCell.appearance().tintColor = theme.cellTintColor
        
    }
}

class CustomNavigationController: UINavigationController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.subscribeOnThemeChange()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        self.subscribeOnThemeChange()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
         self.subscribeOnThemeChange()
    }
    
    private func subscribeOnThemeChange() {
        NotificationCenter.default.addObserver(
        forName: .preferencesChangeTheme, object: nil, queue: nil) { [weak self] notif in
            if let theme = notif.object as? Theme {
                self?.navigationBar.barStyle = theme.barStyle
                self?.navigationBar.barTintColor = theme.navigationBarBarTintColor
                self?.navigationBar.tintColor = theme.navigationBarTintColor
            }
        }
    }
}

class CustomTabBarController: UITabBarController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.subscribeOnThemeChange()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.subscribeOnThemeChange()
    }
    
    private func subscribeOnThemeChange() {
        NotificationCenter.default.addObserver(
        forName: .preferencesChangeTheme, object: nil, queue: nil) { [weak self] notif in
            if let theme = notif.object as? Theme {
                self?.tabBar.tintColor = theme.tabBarTintColor
                self?.tabBar.barTintColor = theme.tabBarBarTintColor
            }
        }
    }
}

