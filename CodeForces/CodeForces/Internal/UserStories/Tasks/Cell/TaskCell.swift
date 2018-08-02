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
//TODO context
    let theme = ThemeManager(preferences: Preferences())

    override func awakeFromNib() {
        super.awakeFromNib()
        localizeEverything()
        configureTagView()
        configureCell()
        topStackView.addArrangedSubview(tagsView)
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
    
    func configure(with model: TaskCellModel) {
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
            countParameterLabel.text = "Очков:" + " \(pointsCount), " +
                "попыток:" + " \(attempts)"
        }
        
        letterTaskLabel.text = model.index
    }
}

extension TaskCell: NibReusable { }

private extension TaskCell {
    func configureCell() {
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        selectedBackgroundView = bgColorView
        
        roundView.layer.cornerRadius = ViewConstants.defaultCornerRadius
        roundView.backgroundColor = theme.currentTheme.cellColor
        taskNameLabel.textColor = theme.currentTheme.cellTitleColor
        solvedCountLabel.textColor = theme.currentTheme.cellTitleColor
        countParameterLabel.textColor = theme.currentTheme.cellTitleColor
        letterTaskLabel.textColor = theme.currentTheme.cellTextColor
        
        switch theme.currentTheme {
        case .light:
            defaultCellBackground.image = UIImage(named: "defaultCellBackgroundColorForLightTheme")
            defaultCellBackground.highlightedImage = UIImage(named: "highlightCellBackgroundColorForLightTheme")
            
        case .dark:
            defaultCellBackground.image = UIImage(named: "defaultCellBackgroundColor")
            defaultCellBackground.highlightedImage = UIImage(named: "highlightCellBackgroundColor")
        }
    }
    
    func configureTagView() {
        tagsView = TagListView()
        tagsView.tagBackgroundColor = theme.currentTheme.tagsColor
        tagsView.tagHighlightedBackgroundColor = theme.currentTheme.tagsColor
        tagsView.tagSelectedBackgroundColor = theme.currentTheme.tagsColor
        tagsView.cornerRadius = ViewConstants.defaultCornerRadius
    }
    
    func localizeEverything() {
        solvedCountLabel.text = L10n.TasksVc.Cell.Header.SolvedCountLabel.text
    }
}
