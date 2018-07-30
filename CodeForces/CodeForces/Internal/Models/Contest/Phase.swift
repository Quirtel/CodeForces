import Foundation

enum Phase: String, Codable {
    case before = "BEFORE"
    case coding = "CODING"
    case pendingSystemTest = "PENDING_SYSTEM_TEST"
    case systemTest = "SYSTEM_TEST"
    case finished = "FINISHED"
}
