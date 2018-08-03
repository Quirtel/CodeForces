import UIKit
import Reusable

class ContestCell: UITableViewCell {
    
    @IBOutlet var roundView: UIView!
    @IBOutlet var contestName: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var durationTime: UILabel!
    @IBOutlet var endTime: UILabel!
    @IBOutlet var remainingLabel: UILabel!
    @IBOutlet var durability: UILabel!
    @IBOutlet private weak var defaultCellBackground: UIImageView!
    
    // TODO: Localize strings
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        selectedBackgroundView = bgColorView
        
        roundView.layer.cornerRadius = ViewConstants.defaultCornerRadius
    }
    
    func configure(theme: Theme) {
        roundView.backgroundColor = theme.cellColor
        contestName.textColor = theme.cellTitleColor
        status.textColor = theme.cellTitleColor
        durationTime.textColor = theme.cellTitleColor
        endTime.textColor = theme.cellTextColor
        remainingLabel.textColor = theme.cellTextColor
        durability.textColor = theme.cellTitleColor
        tintColor = theme.cellTintColor
        
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

extension ContestCell: NibReusable {
    
}
