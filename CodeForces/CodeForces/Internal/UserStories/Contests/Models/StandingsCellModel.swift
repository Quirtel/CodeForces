import UIKit

class StandingsCellModel {
    var participantName = String()
    var rank = 0
    var points: Float = 0
    var isTeam = false
    
    init(participantName: String, rank: Int, points: Float, isTeam: Bool) {
        self.participantName = participantName
        self.rank = rank
        self.points = points
        self.isTeam = isTeam
    }
}
