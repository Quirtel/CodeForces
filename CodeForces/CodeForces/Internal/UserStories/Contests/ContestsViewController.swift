import UIKit

private enum sectionsNames: Int {
    case upcoming = 0
    case finished
}

class ContestsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    let contests = ContestProvider()
    var upcomingContests: [Contest] = []
    var finishedContests: [Contest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ContestCell", bundle: nil),
                           forCellReuseIdentifier: "ContestCellReuseID")
        
        contests.contestList(gym: false, { contestList in
            switch contestList {
            case .success(let list):
                self.upcomingContests = list.compactMap({ $0.phase == .BEFORE || $0.phase == .CODING ? $0 : nil })
                self.finishedContests = list.compactMap({ $0.phase == .FINISHED ? $0 : nil})
            case .error(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

// -MARK: Data Source
extension ContestsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionName = sectionsNames(rawValue: section)!
        switch sectionName {
        case .upcoming:
            return upcomingContests.count
        case .finished:
            return finishedContests.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContestCellReuseID", for: indexPath) as? ContestCell
            
            let sectionName = sectionsNames(rawValue: indexPath.section)!
            
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .full
            formatter.allowedUnits = [.day, .hour, .minute]
            formatter.zeroFormattingBehavior = [.dropAll]
            
            let relativeTimeFormatter = DateFormatter()
            relativeTimeFormatter.doesRelativeDateFormatting = true
            relativeTimeFormatter.dateStyle = .medium
            relativeTimeFormatter.timeStyle = .short
            
            switch sectionName {
            case .upcoming:
                cell?.contestName.text = upcomingContests[indexPath.row].name
                let duration: TimeInterval = TimeInterval(upcomingContests[indexPath.row].durationSeconds)
                let startTime = Date(timeIntervalSince1970: TimeInterval(upcomingContests[indexPath.row].startTimeSeconds!))
                
                let endTime =  Date(timeIntervalSince1970: TimeInterval(upcomingContests[indexPath.row].startTimeSeconds! + upcomingContests[indexPath.row].durationSeconds))
                
                cell?.durationTime.text = formatter.string(from: duration)
                
                switch upcomingContests[indexPath.row].phase {
                case .CODING:
                    cell?.status.text = "Соревнование идёт"
                    cell?.endTime.text = formatter.string(from: Date(timeIntervalSinceNow: 0), to: endTime)!
                    cell?.endTime.isHidden = false
                    cell?.remainingLabel.isHidden = false
                case .BEFORE:
                    cell?.status.text = relativeTimeFormatter.string(from: startTime)
                case .PENDING_SYSTEM_TEST:
                    cell?.status.text = "Ожидание тестирования"
                case .SYSTEM_TEST:
                    cell?.status.text = "Идёт системное тестирование"
                case .FINISHED:
                    cell?.status.text = "Завершено"
                }
                
            case .finished:
                cell?.contestName.text = finishedContests[indexPath.row].name
                
                let startTime = Date(timeIntervalSince1970: TimeInterval(finishedContests[indexPath.row].startTimeSeconds!))
                let duration: TimeInterval = TimeInterval(finishedContests[indexPath.row].durationSeconds)
                
                cell?.status.text = relativeTimeFormatter.string(from: startTime)
                cell?.durationTime.text = formatter.string(from: duration)
                cell?.endTime.isHidden = true
                cell?.remainingLabel.isHidden = true
            }
            
            return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName = sectionsNames(rawValue: section)!
        switch sectionName {
        case .upcoming:
            return L10n.ContestsVc.UpcomingEventsSection.title
        case .finished:
            return L10n.ContestsVc.FinishedEventsSection.title
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
}

extension ContestsViewController: UITableViewDelegate {
    
}
