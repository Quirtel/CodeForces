// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class PartyObject: Object {
    let contestId = RealmOptional<Int>()
    @objc dynamic var members: [Member] = []
    @objc dynamic var participantType: ParticipantType = completeRealmExpression
    let teamId = RealmOptional<Int>()
    @objc dynamic var teamName: String? = nil
    @objc dynamic var ghost: Bool = false
    let room = RealmOptional<Int>()
    let startTimeSeconds = RealmOptional<Int>()
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension Party: RealmRepresentable {
    var realmObject: PartyObject {
        let party = PartyObject()
        party.contestId.value = contestId
        party.members = members
        party.participantType = participantType
        party.teamId.value = teamId
        party.teamName = teamName
        party.ghost = ghost
        party.room.value = room
        party.startTimeSeconds.value = startTimeSeconds
        return party
    }
}
extension PartyObject: StructRepresentable {
    var `struct`: Party {
        return Party(contestId: contestId.value, members: members, participantType: participantType, teamId: teamId.value, teamName: teamName, ghost: ghost, room: room.value, startTimeSeconds: startTimeSeconds.value)
    }
}
