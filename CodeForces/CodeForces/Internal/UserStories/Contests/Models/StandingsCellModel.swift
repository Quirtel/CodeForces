import UIKit

struct StandingsCellModel {
    var participantName = String()
    var rank = String()
    var points = String()
    var isTeam = false
    
    init(participantName: String, rank: String, points: String, isTeam: Bool) {
        self.participantName = participantName
        self.rank = rank
        self.points = points
        self.isTeam = isTeam
    }
}
