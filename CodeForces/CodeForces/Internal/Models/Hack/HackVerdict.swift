import Foundation

enum HackVerdict: String, Codable {
    case hackSuccessful = "HACK_SUCCESSFUL"
    case hackUnsuccessful = "HACK_UNSUCCESSFUL"
    case invalidInput = "INVALID_INPUT"
    case generatorIncompilable = "GENERATOR_INCOMPILABLE"
    case generatorCrashed = "GENERATOR_CRASHED"
    case ignored = "IGNORED"
    case testing = "TESTING"
    case other = "OTHER"
}
