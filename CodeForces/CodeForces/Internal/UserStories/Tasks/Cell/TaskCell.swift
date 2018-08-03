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
    @IBOutlet weak var defaultCellBackground: UIImageView!
    
    
    private var tagsView: TagListView!
    private var contestId = String()

    override func awakeFromNib() {
        super.awakeFromNib()
        localizeEverything()
       
        tagsView = TagListView()
        topStackView.addArrangedSubview(tagsView)
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        selectedBackgroundView = bgColorView
        
        roundView.layer.cornerRadius = ViewConstants.defaultCornerRadius
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        tagsView.removeAllTags()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        tagsView.tagViews.forEach { tag in
            tag.isHighlighted = highlighted
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        tagsView.tagViews.forEach { tag in
            tag.isSelected = selected
        }
    }
    
    func configure(with model: TaskCellModel, theme: Theme) {
        taskNameLabel.text = model.name
        tagsView.addTags(model.tags)
        if let solvedCount = model.solvedCount {
            countParameterLabel.text = solvedCount
        } else {
            solvedCountLabel.isHidden = true
            countParameterLabel.text = ""
        }
        
        if let pointsCount = model.points, let attempts = model.rejectedAttemptCount {
            solvedCountLabel.isHidden = true
            countParameterLabel.text = L10n.TasksVc.Cell.points + ": \(pointsCount), " +
                L10n.TasksVc.Cell.attempts + ": \(attempts)"
        }
        
        letterTaskLabel.text = model.index
        contestId = model.contestId
        
        configureCell(theme: theme)
    }
}

extension TaskCell: NibReusable { }

private extension TaskCell {
    func configureCell(theme: Theme) {
        roundView.backgroundColor = theme.cellColor
        taskNameLabel.textColor = theme.cellTitleColor
        solvedCountLabel.textColor = theme.cellTitleColor
        countParameterLabel.textColor = theme.cellTitleColor
        letterTaskLabel.textColor = theme.cellTextColor
        
        switch theme {
        case .light:
            defaultCellBackground.image = UIImage(named: "defaultCellBackgroundColorForLightTheme")
            defaultCellBackground.highlightedImage = UIImage(named: "highlightCellBackgroundColorForLightTheme")
            
        case .dark:
            defaultCellBackground.image = UIImage(named: "defaultCellBackgroundColor")
            defaultCellBackground.highlightedImage = UIImage(named: "highlightCellBackgroundColor")
        }
        
        configureTagView(theme: theme)
    }
    
    func configureTagView(theme: Theme) {
        tagsView.tagBackgroundColor = theme.tagsColor
        tagsView.tagHighlightedBackgroundColor = theme.tagsColor
        tagsView.tagSelectedBackgroundColor = theme.tagsColor
        tagsView.cornerRadius = ViewConstants.defaultCornerRadius
    }
    
    func localizeEverything() {
        solvedCountLabel.text = L10n.TasksVc.Cell.Header.SolvedCountLabel.text
    }
}
