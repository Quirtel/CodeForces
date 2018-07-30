// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class PartyObject: Object {
    @objc dynamic var contestId: Int? = nil
    @objc dynamic var members: [Member] = completeRealmExpression
    @objc dynamic var participantType: ParticipantType = completeRealmExpression
    @objc dynamic var teamId: Int? = nil
    @objc dynamic var teamName: String? = nil
    @objc dynamic var ghost: Bool = false
    @objc dynamic var room: Int? = nil
    @objc dynamic var startTimeSeconds: Int? = nil
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension Party: RealmRepresentable {
    var realmObject: PartyObject {
        let party = PartyObject()
        party.contestId = contestId
        party.members = members
        party.participantType = participantType
        party.teamId = teamId
        party.teamName = teamName
        party.ghost = ghost
        party.room = room
        party.startTimeSeconds = startTimeSeconds
        return party
    }
}
extension PartyObject: StructRepresentable {
    var `struct`: Party {
        return Party(contestId: contestId, members: members, participantType: participantType, teamId: teamId, teamName: teamName, ghost: ghost, room: room, startTimeSeconds: startTimeSeconds)
    }
}
