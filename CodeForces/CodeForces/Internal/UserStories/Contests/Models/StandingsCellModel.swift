import UIKit

struct StandingsCellModel {
    var participantName = String()
    var rank = String()
    var points = String()
    var isTeam = false
    
    init(_ ranklistRow: RanklistRow) {
        var participantName = String()
        
        var participantIsTeam: Bool = false
        
        if let teamName = ranklistRow.party.teamName {
            participantName = teamName
            participantIsTeam = true
        } else if let handle = ranklistRow.party.members.first {
            participantName = handle.handle
            participantIsTeam = false
        }
        
        self.participantName = participantName
        self.rank = String(ranklistRow.rank)
        self.points = String(ranklistRow.points)
        self.isTeam = participantIsTeam
    }
}
