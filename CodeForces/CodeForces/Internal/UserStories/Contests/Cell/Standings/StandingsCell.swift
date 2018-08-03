import UIKit
import Reusable

class StandingsCell: UITableViewCell {
    @IBOutlet var participantNameLabel: UILabel!
    @IBOutlet var rankNumberLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var roundView: UIView!
    @IBOutlet private weak var defaultCellBackground: UIImageView!
    
    private var participantIsTeam = false
    var context: Context?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundView.layer.cornerRadius = ViewConstants.defaultCornerRadius
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        selectedBackgroundView = bgColorView
    }
    
    func configure(with model: StandingsCellModel, theme: Theme) {
        participantNameLabel.text = model.participantName
        rankNumberLabel.text = model.rank
        pointsLabel.text = model.points
        participantIsTeam = model.isTeam
        
        pointsLabel.textColor = theme.pointsColor
        participantNameLabel.textColor = theme.cellTitleColor
        rankNumberLabel.textColor = theme.cellTextColor
        
        if participantIsTeam {
            if let context = self.context {
                participantNameLabel.textColor = context.preferences.selectedTheme.selectedControlColor
            } else {
                participantNameLabel.textColor = UIColor.colorFromHexString("5bb3ff")
            }
        }
        
        switch theme {
        case .light:
            defaultCellBackground.image = UIImage(named: "defaultCellBackgroundColorForLightTheme")
            defaultCellBackground.highlightedImage = UIImage(named: "highlightCellBackgroundColorForLightTheme")
            
        case .dark:
            defaultCellBackground.image = UIImage(named: "defaultCellBackgroundColor")
            defaultCellBackground.highlightedImage = UIImage(named: "highlightCellBackgroundColor")
        }
    }
}

extension StandingsCell: NibReusable {
    
}
