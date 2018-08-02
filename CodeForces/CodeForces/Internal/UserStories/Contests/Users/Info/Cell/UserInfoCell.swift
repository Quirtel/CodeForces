import UIKit
import Reusable

class UserInfoCell: UITableViewCell{
    @IBOutlet var roundView: UIView!
    @IBOutlet var participantName: UILabel!
    @IBOutlet private weak var defaultCellBackground: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundView.layer.cornerRadius = ViewConstants.defaultCornerRadius
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        selectedBackgroundView = bgColorView
    }
    
    func configure(with model: UserInfoCellModel, theme: Theme) {
        participantName.text = model.handle
        participantName.textColor = theme.cellTitleColor
        
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

extension UserInfoCell: NibReusable {}
