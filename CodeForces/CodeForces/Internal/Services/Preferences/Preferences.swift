import Foundation

class Preferences {
    private static let lastUpdatedDateKey: String = "UpdatedDate"
    

    var lastUpdated: Date {
        set {
            UserDefaults.standard.set(Date(), forKey: Preferences.lastUpdatedDateKey)
        }
        get {
            let value = UserDefaults.standard.object(forKey: Preferences.lastUpdatedDateKey)
            guard let lastUpdated = value as? Date else {
                return Date(timeIntervalSince1970: 0)
            }
            return lastUpdated
        }
    }
}
