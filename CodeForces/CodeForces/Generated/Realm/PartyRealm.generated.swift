// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class PartyRealm: Object { 
 
    let contestId = RealmOptional<Int>() // contestId.value ?? 0    
    var members = List<MemberRealm>()// members.customHash
    @objc dynamic var participantType: String! // participantType 
    let teamId = RealmOptional<Int>() // teamId.value ?? 0
    @objc dynamic var teamName: String? = nil // teamName ?? ""
    @objc dynamic var ghost: Bool = false // "" 
    let room = RealmOptional<Int>() // room.value ?? 0 
    let startTimeSeconds = RealmOptional<Int>() // startTimeSeconds.value ?? 0

    

}

extension PartyRealm: RealmObject {
    var model: Party {
        guard let participantTypeValue = participantType, let participantType = ParticipantType(rawValue: participantTypeValue) else {
            fatalError("Enum case not found")
        }
        
        
        return Party(contestId: contestId.value, members: members.array, participantType: participantType, teamId: teamId.value, teamName: teamName, ghost: ghost, room: room.value, startTimeSeconds: startTimeSeconds.value)
    }

    convenience init(model: Party) {
        self.init()
        
        self.contestId.value = model.contestId        
        self.members = model.members.realmList        
        self.participantType = model.participantType.rawValue        
        self.teamId.value = model.teamId        
        self.teamName = model.teamName        
        self.ghost = model.ghost        
        self.room.value = model.room        
        self.startTimeSeconds.value = model.startTimeSeconds        
    }
}

extension Party: RealmRepresentable {
    var persistenceObject: PartyRealm {
        return PartyRealm(model: self)
    }
}
