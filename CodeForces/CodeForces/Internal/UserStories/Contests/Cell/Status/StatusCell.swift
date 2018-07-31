import UIKit
import Reusable

class StatusCell: UITableViewCell {
    @IBOutlet var participantName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension StatusCell: NibReusable {
    
}
