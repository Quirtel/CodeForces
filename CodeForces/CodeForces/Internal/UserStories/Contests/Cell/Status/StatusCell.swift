import UIKit
import Reusable

class StatusCell: UITableViewCell {
    @IBOutlet private var roundView: UIView!
    @IBOutlet private var participantName: UILabel!
    @IBOutlet private var taskNameLabel: UILabel!
    @IBOutlet private var verdictLabel: UILabel!
    @IBOutlet private var sentTimeLabel: UILabel!
    @IBOutlet private var languageLabel: UILabel!
    @IBOutlet private var timeConsumptionLabel: UILabel!
    @IBOutlet private var memoryConsumptionLabel: UILabel!
     @IBOutlet weak var defaultCellBackground: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundView.layer.cornerRadius = ViewConstants.defaultCornerRadius
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        selectedBackgroundView = bgColorView
    }
    
    func configure(with model: StatusCellModel, theme: Theme) {
        participantName.text = model.participantName
        taskNameLabel.text = model.taskIndex + " - " + model.taskName
        
        participantName.textColor = theme.cellTitleColor
        taskNameLabel.textColor = theme.cellTitleColor
        sentTimeLabel.textColor = theme.cellTitleColor
        languageLabel.textColor = theme.cellTextColor
        verdictLabel.textColor = theme.cellTextColor
        timeConsumptionLabel.textColor = theme.cellTextColor
        memoryConsumptionLabel.textColor = theme.cellTextColor
        
        roundView.backgroundColor = theme.cellColor
        
        switch theme {
        case .light:
            defaultCellBackground.image = UIImage(named: "defaultCellBackgroundColorForLightTheme")
            defaultCellBackground.highlightedImage = UIImage(named: "highlightCellBackgroundColorForLightTheme")
            
        case .dark:
            defaultCellBackground.image = UIImage(named: "defaultCellBackgroundColor")
            defaultCellBackground.highlightedImage = UIImage(named: "highlightCellBackgroundColor")
        }
        
        if let verdict = model.verdict {
            switch verdict {
            case .ok:
                verdictLabel.text = L10n.ContestsVc.StatusCell.Verdict.ok
            case .compilationError:
                verdictLabel.text = L10n.ContestsVc.StatusCell.Verdict.compilationError
            case .crashed, .runtimeError:
                verdictLabel.text = L10n.ContestsVc.StatusCell.Verdict.runtimeError
            case .failed, .wrongAnswer:
                verdictLabel.text = L10n.ContestsVc.StatusCell.Verdict.wrongAnswer + "\(model.passedTestCount)"
            case .testing:
                verdictLabel.text = L10n.ContestsVc.StatusCell.Verdict.testing
            case .security_Violated:
                verdictLabel.text = L10n.ContestsVc.StatusCell.Verdict.securityViolated
            case .rejected:
                verdictLabel.text = L10n.ContestsVc.StatusCell.Verdict.rejected
            case .timeLimitExceeded:
                verdictLabel.text = L10n.ContestsVc.StatusCell.Verdict.timeLimitExceeded
            case .memoryLimitExceeded:
                verdictLabel.text = L10n.ContestsVc.StatusCell.Verdict.memoryLimitExceeded
            default:
                break
            }
        }
        
        sentTimeLabel.text = model.sentTime
        languageLabel.text = model.language
        timeConsumptionLabel.text = model.timeConsumption + L10n.ContestsVc.StatusCell.timeConsumptionLabel
        memoryConsumptionLabel.text =
            String(Float(model.memoryConsumption)! / 1024.0) + L10n.ContestsVc.StatusCell.memoryConsumptionLabel
    }
}

extension StatusCell: NibReusable {
    
}
