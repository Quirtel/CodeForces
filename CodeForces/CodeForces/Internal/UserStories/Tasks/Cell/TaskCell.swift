import UIKit
import Reusable
import TagListView

class TaskCell: UITableViewCell {
    
    @IBOutlet private var topStackView: UIStackView!
    @IBOutlet private var taskNameLabel: UILabel!
    @IBOutlet private var solvedCountLabel: UILabel!
    @IBOutlet private var countParameterLabel: UILabel!
    @IBOutlet private var letterTaskLabel: UILabel!
    @IBOutlet private var roundView: UIView!
    private var tagsView: TagListView!

    override func awakeFromNib() {
        super.awakeFromNib()
        localizeEverything()
        configureTagView()
        
        topStackView.addArrangedSubview(tagsView)
        
        roundView.layer.cornerRadius = ViewConstants.defaultCornerRadius
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tagsView.removeAllTags()
    }
    
    func configure(with model: TaskCellModel) {
        taskNameLabel.text = model.name
        tagsView.addTags(model.tags)
        countParameterLabel.text = model.solvedCount
        letterTaskLabel.text = model.index
        
    }
    
    func configureTagView() {
        tagsView = TagListView()
        tagsView.tagBackgroundColor = UIColor.gray
        tagsView.cornerRadius = ViewConstants.defaultCornerRadius
    }
}

extension TaskCell: NibReusable { }

private extension TaskCell {
    func localizeEverything() {
        solvedCountLabel.text = L10n.TasksVc.Cell.Header.SolvedCountLabel.text
    }
}
