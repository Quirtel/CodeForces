import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var contestId: UILabel!
    @IBOutlet weak var index: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var solvedCount: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
