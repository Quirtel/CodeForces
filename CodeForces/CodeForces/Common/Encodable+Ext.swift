import Foundation
import UIKit

extension Encodable {
    private func asDictionary() throws -> [String : Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments) as? [String : Any]
            else {
                throw NSError()
        }
        return dictionary
    }
    
    var dictionary: [String : Any] {
        guard var dict = (try? asDictionary()) else {
            return [:]
        }
        dict["lang"] = Locale.current.languageCode
        return dict
    }
}
