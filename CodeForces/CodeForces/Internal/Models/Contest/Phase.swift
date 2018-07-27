import Foundation

enum Phase: String, Codable {
    case BEFORE
    case CODING
    case PENDING_SYSTEM_TEST
    case SYSTEM_TEST
    case FINISHED
}
