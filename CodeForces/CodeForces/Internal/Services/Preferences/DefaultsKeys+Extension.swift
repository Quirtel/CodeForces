import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static let updatedDate = DefaultsKey<Date>("UpdatedDate", defaultValue: Date(timeIntervalSince1970: 0))
    static let selectedThemeKey = DefaultsKey<Int>("SelectedThemeKey", defaultValue: 1)
    static let cacheTimeKey = DefaultsKey<Int>("SelectedCacheTimeKey", defaultValue: 0)
}
