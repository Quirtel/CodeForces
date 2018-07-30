import UIKit

private enum sectionsNames: Int {
    case upcoming = 0
    case finished
}

class ContestsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    
    var searchController = UISearchController(searchResultsController: nil)
    let contests = ContestProvider()
    var upcomingContests: [Contest] = []
    var finishedContests: [Contest] = []
    var filteredContests: [Contest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ContestCell", bundle: nil),
                           forCellReuseIdentifier: "ContestCellReuseID")
        
        self.tableView.tableFooterView = UIView()
        
        setupSearchController()
        
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
    
    
    func setupSearchController() {
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = UIColor(white: 0.9, alpha: 0.3)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.definesPresentationContext = true
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
}

// -MARK: Data Source
extension ContestsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredContests.count
        }
        
        let sectionName = sectionsNames(rawValue: section)!
        switch sectionName {
        case .upcoming:
            return upcomingContests.count
        case .finished:
            return finishedContests.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return 1
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContestCellReuseID", for: indexPath) as? ContestCell
            cell?.accessoryType = .disclosureIndicator
            
            let sectionName = sectionsNames(rawValue: indexPath.section)!
            
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .full
            formatter.allowedUnits = [.day, .hour, .minute]
            formatter.zeroFormattingBehavior = [.dropAll]
            
            let relativeTimeFormatter = DateFormatter()
            relativeTimeFormatter.doesRelativeDateFormatting = true
            relativeTimeFormatter.dateStyle = .medium
            relativeTimeFormatter.timeStyle = .short
            
            // MARK: -Search Bar is Active
            if searchController.isActive && searchController.searchBar.text != "" {
                cell?.contestName.text = filteredContests[indexPath.row].name
                
                let startTime = Date(timeIntervalSince1970: TimeInterval(filteredContests[indexPath.row].startTimeSeconds!))
                let duration: TimeInterval = TimeInterval(filteredContests[indexPath.row].durationSeconds)
                
                cell?.status.text = relativeTimeFormatter.string(from: startTime)
                cell?.durationTime.text = formatter.string(from: duration)
                cell?.endTime.isHidden = true
                cell?.remainingLabel.isHidden = true
                
                return cell!
            }
            
            switch sectionName {
            case .upcoming:
                cell?.contestName.text = upcomingContests[indexPath.row].name
                let duration: TimeInterval = TimeInterval(upcomingContests[indexPath.row].durationSeconds)
                let startTime = Date(timeIntervalSince1970: TimeInterval(upcomingContests[indexPath.row].startTimeSeconds!))
                
                let endTime =  Date(timeIntervalSince1970: TimeInterval(upcomingContests[indexPath.row].startTimeSeconds! + upcomingContests[indexPath.row].durationSeconds))
                
                cell?.durationTime.text = formatter.string(from: duration)
                
                switch upcomingContests[indexPath.row].phase {
                case .CODING:
                    cell?.status.text = L10n.ContestsVc.TableViewCell.ContestInProgress.text
                    cell?.endTime.text = formatter.string(from: Date(timeIntervalSinceNow: 0), to: endTime)!
                    cell?.endTime.isHidden = false
                    cell?.remainingLabel.isHidden = false
                case .BEFORE:
                    cell?.status.text = relativeTimeFormatter.string(from: startTime)
                case .PENDING_SYSTEM_TEST:
                    cell?.status.text = L10n.ContestsVc.TableViewCell.PendingTest.text
                case .SYSTEM_TEST:
                    cell?.status.text = L10n.ContestsVc.TableViewCell.SystemTesting.text
                case .FINISHED:
                    cell?.status.text = L10n.ContestsVc.TableViewCell.Finished.text
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
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return "Результаты поиска"
        }
        
        let sectionName = sectionsNames(rawValue: section)!
        switch sectionName {
        case .upcoming:
            return L10n.ContestsVc.UpcomingEventsSection.title
        case .finished:
            return L10n.ContestsVc.FinishedEventsSection.title
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func filterRowsForSearchedText(_ searchText: String) {
        filteredContests = finishedContests.filter({( model : Contest) -> Bool in
            return model.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

// -MARK: Delegate
extension ContestsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = storyboard?.instantiateViewController(withIdentifier: "ContestInfoViewController")
        
        if let viewController = nextViewController as? ContestInfoViewController {
            
            if searchController.isActive && searchController.searchBar.text != "" {
                viewController.contestId = filteredContests[indexPath.row].id
            } else {
                let sectionName = sectionsNames(rawValue: indexPath.section)!
                switch sectionName {
                case .upcoming:
                    viewController.contestId = upcomingContests[indexPath.row].id
                case .finished:
                    viewController.contestId = finishedContests[indexPath.row].id
                }
            }
            
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
}

extension ContestsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text {
            filterRowsForSearchedText(term)
        }
    }
}
