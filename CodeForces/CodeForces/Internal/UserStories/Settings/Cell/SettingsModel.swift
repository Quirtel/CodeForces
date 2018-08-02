import Foundation

struct SectionData {
    let title: String
    let rowData: RowType
}

enum RowType {
    case theme(allCases: [Theme])
    case cacheTime(allCases: [CacheTime])
}

extension Theme {
    static let title = L10n.SettingsVc.Theme.title
    var title: String {
        switch self {
        case .light:
            return L10n.SettingsVc.Theme.light
        case .dark:
            return L10n.SettingsVc.Theme.dark
        }
    }
}

extension CacheTime {
    static let title = L10n.SettingsVc.Cache.title
    var title: String {
        switch self {
        case .never:
            return L10n.SettingsVc.Cache.Time.never
        case .oneDay:
            return L10n.SettingsVc.Cache.Time.oneday
        case .twoDays:
            return L10n.SettingsVc.Cache.Time.twodays
        case .threeDays:
            return L10n.SettingsVc.Cache.Time.threedays
        case .week:
            return L10n.SettingsVc.Cache.Time.week
        }
    }
    
}


