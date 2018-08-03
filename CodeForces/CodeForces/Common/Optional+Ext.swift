import Foundation

extension Optional where Wrapped == [String] {
    var semicolonSeparated: String? {
        guard let unwrapped = self else {return nil }
        var resultString = ""
        for (id, elem) in unwrapped.enumerated() {
            resultString.append(elem)
            if id < unwrapped.count - 1 {
                resultString.append(";")
            }
        }
        return resultString.isEmpty ? nil : resultString
    }
}
