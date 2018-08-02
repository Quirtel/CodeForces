import UIKit
import Reusable

private enum SectionsNames: Int {
    case upcoming = 0
    case finished
}

class ContestsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var context = NetworkService()
    private var upcomingContests: [Contest] = []
    private var finishedContests: [Contest] = []
    private var filteredContests: [Contest] = []
    private let relativeTimeFormatter = DateFormatter()
    private let formatter = DateComponentsFormatter()
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let alertResponseError = UIAlertController(
        title: "Ошибка",
        message: "Не удалось получить соревнования. Повторите запрос позже", preferredStyle: .alert)
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        extendedLayoutIncludesOpaqueBars = true
        
        setupTableView()
        setupSearchController()
        setupFormatters()
        fetchContestList()
    }
    
    
    func setupTableView() {
        tableView.register(cellType: ContestCell.self)
        
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        
        alertResponseError.addAction(UIAlertAction(title: "OK" , style: .default, handler: { _ in
            self.tableView.tableFooterView?.isHidden = true
        }))
        
        tableView.separatorStyle = .none
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
        tableView.refreshControl = refreshControl
    }
    
    func setupSearchController() {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        
        searchController.definesPresentationContext = true
        definesPresentationContext = true
    }
    
    func setupFormatters() {
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.zeroFormattingBehavior = [.dropAll]
        
        relativeTimeFormatter.doesRelativeDateFormatting = true
        relativeTimeFormatter.dateStyle = .medium
        relativeTimeFormatter.timeStyle = .short
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        fetchContestList()
    }
    
    func fetchContestList() {
        context.fetchContestList(
            requestParams: ContestListRequest(gym: false), { [weak self] contestList in
                guard let sself = self else { return }
                switch contestList {
                case .success(let list):
                    sself.upcomingContests = list.compactMap(
                        { $0.phase == .before || $0.phase == .coding ? $0 : nil })
                    sself.finishedContests = list.compactMap(
                        { $0.phase == .finished ? $0 : nil })
                    sself.tableView.tableFooterView?.isHidden = true
                case .error( _):
                    sself.present(sself.alertResponseError, animated: true)
                }
                sself.refreshControl.endRefreshing()
                sself.tableView.reloadData()
        })
    }
}

// -MARK: Data Source
extension ContestsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredContests.count
        }
        
        let sectionName = SectionsNames(rawValue: section)!
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContestCell
            
            let sectionName = SectionsNames(rawValue: indexPath.section)!
            
            if searchController.isActive && searchController.searchBar.text != "" {
                cell.contestName.text = filteredContests[indexPath.row].name
                
                let startTime = Date(timeIntervalSince1970: TimeInterval(filteredContests[indexPath.row].startTimeSeconds!))
                let duration = TimeInterval(filteredContests[indexPath.row].durationSeconds)
                
                cell.status.text = relativeTimeFormatter.string(from: startTime)
                cell.durationTime.text = formatter.string(from: duration)
                cell.endTime.isHidden = true
                cell.remainingLabel.isHidden = true
                
                return cell
            }
            
            switch sectionName {
            case .upcoming:
                cell.accessoryType = .none
                cell.contestName.text = upcomingContests[indexPath.row].name
                let duration = TimeInterval(upcomingContests[indexPath.row].durationSeconds)
                let startTime = Date(timeIntervalSince1970:
                    TimeInterval(upcomingContests[indexPath.row].startTimeSeconds!))
                
                let endTime =  Date(timeIntervalSince1970:
                    TimeInterval(upcomingContests[indexPath.row].startTimeSeconds! + upcomingContests[indexPath.row].durationSeconds))
                
                cell.durationTime.text = formatter.string(from: duration)
                
                switch upcomingContests[indexPath.row].phase {
                case .coding:
                    cell.status.text = L10n.ContestsVc.TableViewCell.ContestInProgress.text
                    cell.endTime.text = formatter.string(from: Date(timeIntervalSinceNow: 0), to: endTime)!
                    cell.endTime.isHidden = false
                    cell.remainingLabel.isHidden = false
                case .before:
                    cell.status.text = relativeTimeFormatter.string(from: startTime)
                case .pendingSystemTest:
                    cell.status.text = L10n.ContestsVc.TableViewCell.PendingTest.text
                case .systemTest:
                    cell.status.text = L10n.ContestsVc.TableViewCell.SystemTesting.text
                case .finished:
                    cell.status.text = L10n.ContestsVc.TableViewCell.Finished.text
                }
                
            case .finished:
                cell.accessoryType = .disclosureIndicator
                cell.contestName.text = finishedContests[indexPath.row].name
                
                let startTime = Date(timeIntervalSince1970:
                    TimeInterval(finishedContests[indexPath.row].startTimeSeconds!))
                let duration: TimeInterval = TimeInterval(
                    finishedContests[indexPath.row].durationSeconds)
                
                cell.status.text = relativeTimeFormatter.string(from: startTime)
                cell.durationTime.text = formatter.string(from: duration)
                cell.endTime.isHidden = true
                cell.remainingLabel.isHidden = true
            }
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return "Результаты поиска"
        }
        
        let sectionName = SectionsNames(rawValue: section)!
        switch sectionName {
        case .upcoming:
            return L10n.ContestsVc.UpcomingEventsSection.title
        case .finished:
            return L10n.ContestsVc.FinishedEventsSection.title
        }
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
        let nextViewController = StoryboardScene.Contests.contestInfoViewController.instantiate()
        
        let sectionName = SectionsNames(rawValue: indexPath.section)!
        tableView.deselectRow(at: indexPath, animated: true)
        
        if searchController.isActive && searchController.searchBar.text != "" {
            nextViewController.contestId = filteredContests[indexPath.row].id
        } else {
            switch sectionName {
            case .upcoming:
                return
                    nextViewController.contestId = upcomingContests[indexPath.row].id
            case .finished:
                nextViewController.contestId = finishedContests[indexPath.row].id
            }
        }
        
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

extension ContestsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text {
            filterRowsForSearchedText(term)
        }
    }
}
