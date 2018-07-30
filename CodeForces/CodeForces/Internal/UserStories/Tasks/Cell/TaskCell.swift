import UIKit
import Reusable

class TaskCell: UITableViewCell {
    
    @IBOutlet private var taskName: UILabel!
    @IBOutlet private var tags: UILabel!
    @IBOutlet private var solvedCountLabel: UILabel!
    @IBOutlet private var countParameter: UILabel!
    @IBOutlet private var letterTask: UILabel!
    
    @IBOutlet private var roundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        localizeEverything()
        roundView.layer.cornerRadius = ViewConstants.defaultCornerRadius
    }
    
    func configure(with model: Any) {
        
    }
}

extension TaskCell: NibReusable { }

private extension TaskCell {
    func localizeEverything() {
        solvedCountLabel.text = L10n.TasksVc.Cell.Header.SolvedCountLabel.text
    }
}

