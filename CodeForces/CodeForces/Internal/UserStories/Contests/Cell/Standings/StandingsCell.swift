import UIKit
import Reusable

class StandingsCell: UITableViewCell {
    @IBOutlet var participantName: UILabel!
    @IBOutlet var rankNumber: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    
    private var participantIsTeam = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: StandingsCellModel) {
        participantName.text = model.participantName
        rankNumber.text = String(model.rank)
        pointsLabel.text = String(model.points)
        participantIsTeam = model.isTeam
        
        if participantIsTeam {
            participantName.textColor = UIColor.blue
        }
    }
}

extension StandingsCell: NibReusable {
    
}
