import Foundation

enum HackVerdict: String, Codable {
    case HACK_SUCCESSFUL
    case HACK_UNSUCCESSFUL
    case INVALID_INPUT
    case GENERATOR_INCOMPILABLE
    case GENERATOR_CRASHED
    case IGNORED
    case TESTING
    case OTHER
}
