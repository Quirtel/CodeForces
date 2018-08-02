import UIKit
import Reusable

private enum sectionsNames: Int {
    case party = 0
    case tasks
}

class UserContestStatusViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    
    private var users: Party? = nil
    private var tasks: [TaskCellModel] = []
    private var currentRanklist: RanklistRow? = nil
    var context: Context?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    func configure(contestId: String, ranklistRow: RanklistRow, tasks: [Problem]) {
        self.users = ranklistRow.party
        for it in 0..<tasks.count {
            self.tasks.append(TaskCellModel(contestId: contestId, name: tasks[it].name, tags: tasks[it].tags, solvedCount: nil, index: tasks[it].index, rejectedAttemptCount: String(ranklistRow.problemResults[it].rejectedAttemptCount), points: String(ranklistRow.problemResults[it].points.rounded())))
        }
    }
    
    func setupTableView() {
        tableView.register(cellType: TaskCell.self)
        tableView.register(cellType: UserInfoCell.self)
        
//        spinner.startAnimating()
//        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
//
//        alertResponseError.addAction(UIAlertAction(title: "OK" , style: .default, handler: { _ in
//            self.tableView.tableFooterView?.isHidden = true
//        }))
//
//        tableView.separatorStyle = .none
//        tableView.tableFooterView = spinner
//        tableView.tableFooterView?.isHidden = false
//        tableView.refreshControl = refreshControl
    }
}

extension UserContestStatusViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return users!.members.count
        }
        
        if section == 1 {
            return tasks.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return L10n.ContestsVc.users
        }
        if section == 1 {
            return L10n.ContestsVc.tasks
        }
        
        return ""
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentSection = sectionsNames(rawValue: indexPath.section)!
        
        switch currentSection {
        case .party:
            let cell = tableView.dequeueReusableCell(for: indexPath) as UserInfoCell
            
            cell.configure(with: UserInfoCellModel((users?.members[indexPath.row].handle)!))
            
            return cell
        case .tasks:
            let cell = tableView.dequeueReusableCell(for: indexPath) as TaskCell
            cell.configure(with: tasks[indexPath.row], theme: context!.preferences.selectedTheme)
            return cell
        }
        
    }
}
