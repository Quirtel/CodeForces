import UIKit
import Reusable

class TaskCell: UITableViewCell {
    
    @IBOutlet private var taskNameLabel: UILabel!
    @IBOutlet private var tagsLabel: UILabel!
    @IBOutlet private var solvedCountLabel: UILabel!
    @IBOutlet private var countParameterLabel: UILabel!
    @IBOutlet private var letterTaskLabel: UILabel!
    
    @IBOutlet private var roundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        localizeEverything()
        roundView.layer.cornerRadius = ViewConstants.defaultCornerRadius
    }
    
    func configure(with model: TaskCellModel) {    
        taskNameLabel.text = model.name
        tagsLabel.text = model.tags.joined(separator: ", ")
        countParameterLabel.text = model.solvedCount
        letterTaskLabel.text = model.index
        
    }
}

extension TaskCell: NibReusable { }

private extension TaskCell {
    func localizeEverything() {
        solvedCountLabel.text = L10n.TasksVc.Cell.Header.SolvedCountLabel.text
    }
}

