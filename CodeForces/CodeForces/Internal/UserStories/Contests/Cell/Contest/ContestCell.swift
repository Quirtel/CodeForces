import UIKit
import Reusable

class ContestCell: UITableViewCell {
    @IBOutlet var contestName: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var durationTime: UILabel!
    @IBOutlet var endTime: UILabel!
    @IBOutlet var remainingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension ContestCell: NibReusable {
    
}
