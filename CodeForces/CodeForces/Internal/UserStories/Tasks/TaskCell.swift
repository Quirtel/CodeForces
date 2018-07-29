import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var contestId: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var solvedCount: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        solvedCount.layer.masksToBounds = true
        solvedCount.layer.cornerRadius = 15
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
