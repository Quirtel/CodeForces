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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundView.layer.cornerRadius = ViewConstants.defaultCornerRadius
    }
    
    func configure(with model: StatusCellModel) {
        participantName.text = model.participantName
        taskNameLabel.text = model.taskIndex + " - " + model.taskName
        
        if let verdict = model.verdict {
            switch verdict {
            case .ok:
                verdictLabel.text = "Полное решение"
            case .compilationError:
                verdictLabel.text = "Ошибка компиляции"
            case .crashed, .runtimeError:
                verdictLabel.text = "Ошибка времени выполнения"
            case .failed, .wrongAnswer:
                verdictLabel.text = "Неправильный ответ на одном из тестов"
            case .testing:
                verdictLabel.text = "Идёт тестирование"
            case .security_Violated:
                verdictLabel.text = "Нарушение правил"
            case .rejected:
                verdictLabel.text = "Отклонено"
            case .timeLimitExceeded:
                verdictLabel.text = "Превышено ограничение времени"
            case .memoryLimitExceeded:
                verdictLabel.text = "Превышено ограничение памяти"
            default:
                break
            }
        }
        
        sentTimeLabel.text = model.sentTime
        languageLabel.text = model.language
        timeConsumptionLabel.text = model.timeConsumption + " ms"
        memoryConsumptionLabel.text = String(Float(model.memoryConsumption)! / 1024.0) + " KB"
    }
}

extension StatusCell: NibReusable {
    
}
