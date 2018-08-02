import UIKit
import Reusable

class UserInfoCell: UITableViewCell{
    @IBOutlet var roundView: UIView!
    @IBOutlet var participantName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundView.layer.cornerRadius = ViewConstants.defaultCornerRadius
    }
    
    func configure(with model: UserInfoCellModel) {
        participantName.text = model.handle
    }
}

extension UserInfoCell: NibReusable {}
