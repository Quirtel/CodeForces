import Foundation

enum CacheTime: Int {
    case never
    case oneDay
    case twoDays
    case threeDays
    case week
    
    var seconds: TimeInterval {
        switch self {
        case .never:
            return 0
        case .oneDay:
            return 1 * 60 * 60 * 24
        case .twoDays:
            return 2 * 60 * 60 * 24
        case .threeDays:
            return 3 * 60 * 60 * 24
        case .week:
            return 7 * 60 * 60 * 24
        }
    }
}
