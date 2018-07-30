import Foundation

enum ParticipantType: String, Codable {
    case contestant = "CONTESTANT"
    case practice = "PRACTICE"
    case virtual = "VIRTUAL"
    case manager = "MANAGER"
    case outOfCompletion = "OUT_OF_COMPETITION"
}
