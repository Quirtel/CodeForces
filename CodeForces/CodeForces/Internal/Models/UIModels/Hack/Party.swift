import Foundation

//sourcery: RealmStruct
struct Party: Codable {
    let contestId: Int?
    let members: [Member]
    let participantType: ParticipantType
    let teamId: Int?
    let teamName: String?
    let ghost: Bool
    let room: Int?
    let startTimeSeconds: Int?
}
