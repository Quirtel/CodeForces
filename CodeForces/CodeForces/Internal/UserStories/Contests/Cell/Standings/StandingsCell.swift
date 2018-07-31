import UIKit
import Reusable

class StandingsCell: UITableViewCell {
    @IBOutlet var participantNameLabel: UILabel!
    @IBOutlet var rankNumberLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var roundView: UIView!
    
    private var participantIsTeam = false
    
    override func awakeFromNib() {
        roundView.layer.cornerRadius = ViewConstants.defaultCornerRadius
        super.awakeFromNib()
    }
    
    func configure(with model: StandingsCellModel) {
        participantNameLabel.text = model.participantName
        rankNumberLabel.text = model.rank
        pointsLabel.text = model.points
        participantIsTeam = model.isTeam
        
        if participantIsTeam {
            participantNameLabel.textColor = UIColor.blue
        }
    }
}

extension StandingsCell: NibReusable {
    
}
