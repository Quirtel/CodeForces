import UIKit
import Reusable

class ContestCell: UITableViewCell {
    // TODO: Make IBOutlets private
    @IBOutlet var roundView: UIView!
    @IBOutlet var contestName: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var durationTime: UILabel!
    @IBOutlet var endTime: UILabel!
    @IBOutlet var remainingLabel: UILabel!
    
    // TODO: Localize strings
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundView.layer.cornerRadius = ViewConstants.defaultCornerRadius
    }
}

extension ContestCell: NibReusable {
    
}
