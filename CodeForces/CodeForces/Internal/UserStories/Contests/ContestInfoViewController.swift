import UIKit

private enum SegmentsNames: Int {
    case tasks = 0
    case status
    case standings
    
    
}

class ContestInfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var segmentIndicator: UISegmentedControl!
    @IBOutlet var segmentView: UIView!
    @IBOutlet weak var segmentcontrol: UISegmentedControl!
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    //TODO: make array varform to Problems Wrapper
    private var contestProblems: [Problem] = []
    private var filteredContestProblems: [Problem] = []
    
    private var contestStatus: [Submission] = []
    private var filteredContestStatus: [Submission] = []
    
    private var ranklistRows: [RanklistRow] = []
    private var filteredRanklistRows: [RanklistRow] = []
    
    
    var contestId = 0
    var currentOffsetStandings = 0
    var currentOffsetStatus = 0
    var currentSearchQuery = String()
    
    var context: Context?
    
    private var shouldFetchStandings = true
    private var shouldFetchStatus = true
    private var canEditSearchBar = true
    private var refresherPulled = false
    private var currentDataType = SegmentsNames(rawValue: 0)
    private let relativeTimeFormatter = DateFormatter()
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let alertHandleError = UIAlertController(
        title: L10n.Alert.Title.error,
        message: L10n.ContestsVc.AlertHandleError.message, preferredStyle: .alert)
    let alertConnectionError = UIAlertController(
        title: L10n.Alert.Title.error,
        message: L10n.ContestsVc.AlertHandleError.message, preferredStyle: .alert)
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertHandleError.addAction(UIAlertAction(title: "OK" , style: .default,
                                                 handler: { _ in}))
        
        tableView.tableHeaderView = UIView()
        tableView.separatorStyle = .none
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
        tableView.addSubview(refreshControl)
        
        tableView.contentInset = UIEdgeInsets(
            top: segmentView.bounds.height, left: 0, bottom: 0, right: 0)
        
        tableView.scrollIndicatorInsets = UIEdgeInsets(
            top: segmentView.bounds.height, left: 0, bottom: 0, right: 0)
        
        segmentView.layer.borderWidth = 1
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        
        setupSearchController()
        setupFormatters()
        
        tableView.register(cellType: TaskCell.self)
        tableView.register(cellType: StatusCell.self)
        tableView.register(cellType: StandingsCell.self)
        
        fetchTasks()
        fetchStatus(offset: 1, count: 30, nil)
        fetchStandings(offset: 1, count: 30, nil)
        
        subscribeOnThemeChange()
        applyTheme()
    }
    
    private func subscribeOnThemeChange() {
        NotificationCenter.default.addObserver(
        forName: .preferencesChangeTheme, object: nil, queue: nil) { [weak self] _ in
            self?.applyTheme()
            self?.tableView.reloadData()
        }
    }
    
    private func applyTheme() {
        if let context = self.context {
            tableView.backgroundView = nil
            tableView.backgroundColor = context.preferences.selectedTheme.backgroundColor
            segmentView.backgroundColor = context.preferences.selectedTheme.backgroundColor
            spinner.color = context.preferences.selectedTheme.spinnerColor
            refreshControl.tintColor = context.preferences.selectedTheme.spinnerColor
            segmentView.layer.borderColor = context.preferences.selectedTheme.backgroundColor.cgColor
            segmentIndicator.tintColor = context.preferences.selectedTheme.selectedControlColor
            
            segmentIndicator.setTitle(L10n.ContestInfoVc.SesegmentIndicator.tasks, forSegmentAt: SegmentsNames.tasks.rawValue)
            segmentIndicator.setTitle(L10n.ContestInfoVc.SesegmentIndicator.status, forSegmentAt: SegmentsNames.status.rawValue)
            segmentIndicator.setTitle(L10n.ContestInfoVc.SesegmentIndicator.standings, forSegmentAt: SegmentsNames.standings.rawValue)
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        return (searchController.searchBar.text?.isEmpty ?? true)
    }
    
    func setupFormatters() {
        relativeTimeFormatter.doesRelativeDateFormatting = true
        relativeTimeFormatter.dateStyle = .medium
        relativeTimeFormatter.timeStyle = .short
    }
    
    // -MARK: Fetch Tasks
    
    func fetchTasks() {
        let segIndex = SegmentsNames(rawValue: self.segmentIndicator.selectedSegmentIndex)!
        
        if segIndex != .tasks {
            return
        }
        
        let request = ContestStandingsRequest(
            contestId: contestId, from: 1, count: 1,
            handles: nil, room: nil, showUnofficial: false)
        
        context?.contentService.fetchContestStandings(
            withRequestParams: request, { [weak self] result in
                guard let strongSelf = self else { return }
                
                switch result {
                case .success(let list):
                    strongSelf.contestProblems = list.problems
                    
                    strongSelf.tableView.setContentOffset(
                        strongSelf.tableView.contentOffset, animated: true)
                    
                    strongSelf.refresherPulled = false
                    strongSelf.refreshControl.endRefreshing()
                    
                    strongSelf.tableView.reloadData()
                    strongSelf.tableView.tableFooterView?.isHidden = true
                case .error(let error):
                    print(error)
                }
        })
    }
    
    // -MARK: Fetch Status
    func fetchStatus(offset: Int, count: Int, _ handle: String?) {
        let segIndex = SegmentsNames(rawValue: self.segmentIndicator.selectedSegmentIndex)!
        
        if segIndex != .status {
            return
        }
        
        shouldFetchStatus = false
        
        var handleToSearch: String? = nil
        
        if let handle = handle {
            if handle.isEmpty {
                handleToSearch = nil
            } else {
                handleToSearch = handle
            }
        }
        
        let request = ContestStatusRequest(
            contestId: contestId, handle: handleToSearch, from: offset, count: count)
        context?.contentService.fetchContestStatus(
            withRequestParams: request, { [weak self] result in
                
                guard let strongSelf = self else { return }
                
                switch result {
                case .success(let list):
                    
                    if let handle = handleToSearch {
                        if strongSelf.refresherPulled {
                            strongSelf.filteredContestStatus.removeAll()
                        }
                        
                        strongSelf.filteredContestStatus.append(contentsOf: list.compactMap({ $0 }))
                    } else {
                        if strongSelf.refresherPulled {
                            strongSelf.contestStatus.removeAll()
                        }
                        strongSelf.contestStatus.append(contentsOf: list.compactMap({ $0 }))
                    }
                    
                    let indexPaths = Array(offset-1..<offset-1+list.count)
                        .map({ IndexPath(row: $0, section: 0) })
                    
//                    if handle != nil || strongSelf.refresherPulled {
//                        strongSelf.tableView.reloadData()
//                    } else {
//                        strongSelf.tableView.setContentOffset(
//                            strongSelf.tableView.contentOffset, animated: true)
//
//                        strongSelf.tableView.beginUpdates()
//                        strongSelf.tableView.insertRows(
//                            at: indexPaths, with: .fade)
//                        strongSelf.tableView.endUpdates()
//                    }
//
                    strongSelf.tableView.setContentOffset(
                        strongSelf.tableView.contentOffset, animated: true)


                    strongSelf.tableView.reloadData()
                    strongSelf.tableView.tableFooterView?.isHidden = true
                    
                    if list.count > 0 {
                        strongSelf.shouldFetchStatus = true
                    }
                    strongSelf.currentDataType = .status
                    strongSelf.refresherPulled = false
                    strongSelf.refreshControl.endRefreshing()
                case .error(let error):
                    print(error)
                    strongSelf.tableView.tableFooterView?.isHidden = true
                    strongSelf.tableView.reloadData()
                }
        })
    }
    
    // -MARK: Fetch Standings
    func fetchStandings(offset: Int, count: Int, _ handles: [String]?) {
        
        let segIndex = SegmentsNames(rawValue: self.segmentIndicator.selectedSegmentIndex)!
        
        if segIndex != .standings {
            return
        }
        
        var handlesArrayToSearch: [String]? = nil
        
        if let handles = handles {
            if handles.isEmpty {
                handlesArrayToSearch = nil
            } else {
                handlesArrayToSearch = handles
            }
        }
        
        shouldFetchStandings = false
        let request = ContestStandingsRequest(
            contestId: contestId, from: offset, count: count,
            handles: handlesArrayToSearch, room: nil, showUnofficial: false)
        
        context?.contentService.fetchContestStandings(
            withRequestParams: request, {[weak self] result in
                
                guard let strongSelf = self else { return }
                
                switch result {
                case .success(let list):
                    if let handles = handlesArrayToSearch {
                        if strongSelf.refresherPulled {
                            strongSelf.filteredRanklistRows.removeAll()
                        }
                        
                        strongSelf.filteredRanklistRows.append(contentsOf: list.rows)
                        
                    } else {
                        
                        if strongSelf.refresherPulled {
                            strongSelf.ranklistRows.removeAll()
                        }
                        
                        strongSelf.ranklistRows.append(contentsOf: list.rows)
                    }
                    
                    let indexPaths = Array(offset-1..<offset-1+list.rows.count)
                        .map({ IndexPath(row: $0, section: 0) })
                    
                    
//                    if handles != nil || strongSelf.refresherPulled {
//                        strongSelf.tableView.reloadData()
//                    } else {
//                        strongSelf.tableView.setContentOffset(
//                            strongSelf.tableView.contentOffset, animated: true)
//
//                        strongSelf.tableView.beginUpdates()
//                        strongSelf.tableView.insertRows(
//                            at: indexPaths, with: .fade)
//                        strongSelf.tableView.endUpdates()
//                    }
                    
                    strongSelf.tableView.setContentOffset(
                        strongSelf.tableView.contentOffset, animated: true)

                    strongSelf.tableView.tableFooterView?.isHidden = true
                    strongSelf.tableView.reloadData()
                    
                    
                    if list.rows.count > 0 {
                        strongSelf.shouldFetchStandings = true
                    }
                    
                    strongSelf.currentDataType = .standings
                    strongSelf.refresherPulled = false
                    strongSelf.refreshControl.endRefreshing()
                case .error(let error):
                    print(error)
                    strongSelf.tableView.tableFooterView?.isHidden = true
                    strongSelf.tableView.reloadData()
                }
        })
    }
    
    func setupSearchController() {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.searchController?.searchBar.delegate = self
            navigationItem.hidesSearchBarWhenScrolling = true
            
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.definesPresentationContext = true
    }
    
    
    // -MARK: Actions
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refresherPulled = true
        
        let segIndex = SegmentsNames(rawValue: self.segmentIndicator.selectedSegmentIndex)!
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
        tableView.reloadData()
        
        switch segIndex {
        case .standings:
            if !currentSearchQuery.isEmpty {
                fetchStandings(offset: 1, count: 30, currentSearchQuery.split(separator: ",").map(String.init))
                if filteredRanklistRows.count > 0 {
                    tableView.scrollToRow(
                        at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
                }
            } else {
                fetchStandings(offset: 1, count: 30, currentSearchQuery.split(separator: ",").map(String.init))
                if ranklistRows.count > 0 {
                    tableView.scrollToRow(
                        at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
                }
            }
        case .status:
            if !currentSearchQuery.isEmpty {
                fetchStatus(offset: 1, count: 30, currentSearchQuery)
                if filteredContestStatus.count > 0 {
                    tableView.scrollToRow(
                        at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
                }
            } else {
                fetchStatus(offset: 1, count: 30, currentSearchQuery)
                if contestStatus.count > 0 {
                    tableView.scrollToRow(
                        at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
                }
            }
            
        case .tasks:
            refreshControl.endRefreshing()
            if !currentSearchQuery.isEmpty {
                filterRowsForSearchedText(currentSearchQuery)
                
                if filteredContestProblems.count > 0 {
                    tableView.scrollToRow(
                        at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
                }
            } else {
                if contestProblems.count > 0 {
                    tableView.scrollToRow(
                        at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
                }
            }
        }
        tableView.tableFooterView?.isHidden = true
    }
    
    
    
    //        segmentValueChanged(segmentIndicator)
    
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        let segIndex = SegmentsNames(rawValue: self.segmentIndicator.selectedSegmentIndex)!
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
        tableView.reloadData()
        
        switch segIndex {
        case .standings:
            if !currentSearchQuery.isEmpty {
                if filteredRanklistRows.count > 0 {
                    fetchStandings(offset: filteredRanklistRows.count + 1, count: 30, currentSearchQuery.split(separator: ",").map(String.init))
                    tableView.scrollToRow(
                        at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
                } else {
                    fetchStandings(offset: 1, count: 30, currentSearchQuery.split(separator: ",").map(String.init))
                }
            } else {
                if ranklistRows.count > 0 {
                    fetchStandings(offset: ranklistRows.count + 1, count: 30, currentSearchQuery.split(separator: ",").map(String.init))
                    
                    tableView.scrollToRow(
                        at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
                } else {
                    fetchStandings(offset: 1, count: 30, currentSearchQuery.split(separator: ",").map(String.init))
                }
            }
        case .status:
            if !currentSearchQuery.isEmpty {
                if filteredContestStatus.count == 0 {
                    fetchStatus(offset: 1, count: 30, currentSearchQuery)
                } else {
                    fetchStatus(offset: filteredContestStatus.count + 1, count: 30, currentSearchQuery)
                }
                
                if filteredContestStatus.count > 0 {
                    tableView.scrollToRow(
                        at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
                }
            } else if contestStatus.count >= 0 {
                fetchStatus(offset: contestStatus.count + 1, count: 30, currentSearchQuery)
                
                if contestStatus.count > 0 {
                    tableView.scrollToRow(
                        at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
                }
            }
        case .tasks:
            refreshControl.endRefreshing()
            if (filteredContestProblems.count == 0 && !currentSearchQuery.isEmpty) {
                filterRowsForSearchedText(currentSearchQuery)
                
                if filteredContestProblems.count > 0 {
                    tableView.scrollToRow(
                        at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
                }
            } else if contestProblems.count >= 0 {
                if contestProblems.count > 0 {
                    tableView.scrollToRow(
                        at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
                }
            }
        }
        tableView.tableFooterView?.isHidden = true
    }
    
}

// -MARK: Data Source
extension ContestInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let segIndex = SegmentsNames(rawValue: self.segmentIndicator.selectedSegmentIndex)!
        
        switch segIndex {
        case .standings:
            if searchBarIsEmpty() {
                return ranklistRows.count
            } else {
                return filteredRanklistRows.count
            }
        case .status:
            if searchBarIsEmpty()  {
                return contestStatus.count
            } else {
                return filteredContestStatus.count
            }
        case .tasks:
            if searchBarIsEmpty()  {
                return contestProblems.count
            } else {
                return filteredContestProblems.count
            }
        }
    }
    
    func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let segIndex = SegmentsNames(rawValue: self.segmentIndicator.selectedSegmentIndex)!
        
        switch segIndex {
        case .tasks:
            // -MARK: Tasks Cells
            let taskCell = tableView.dequeueReusableCell(for: indexPath) as TaskCell
            
            let currentTask: Problem
            
            if searchBarIsEmpty() {
                currentTask = contestProblems[indexPath.row]
            } else {
                currentTask = filteredContestProblems[indexPath.row]
            }
            
            let model = TaskCellModel(
                contestId: String(contestId), name: currentTask.name, tags: currentTask.tags, solvedCount: nil, index: currentTask.index, rejectedAttemptCount: nil, points: nil)
            
            taskCell.configure(with: model, theme: context?.preferences.selectedTheme ?? .light)
            
            tableView.tableFooterView?.isHidden = true
            return taskCell
        case .standings:
            // -MARK: Standings Cells
            let standingsCell = tableView.dequeueReusableCell(for: indexPath) as StandingsCell
            let currentRanklistRow: RanklistRow
            
            if searchBarIsEmpty() {
                currentRanklistRow = ranklistRows[indexPath.row]
            } else {
                currentRanklistRow = filteredRanklistRows[indexPath.row]
            }
            
            let model = StandingsCellModel(currentRanklistRow)
            standingsCell.configure(with: model, theme: context?.preferences.selectedTheme ?? .light)
            
            tableView.tableFooterView?.isHidden = true
            return standingsCell
            
        case .status:
            // -MARK: Status Cells
            let statusCell = tableView.dequeueReusableCell(for: indexPath) as StatusCell
            
            let currentSubmission: Submission
            
            if searchBarIsEmpty() {
                currentSubmission = contestStatus[indexPath.row]
            } else {
                currentSubmission = filteredContestStatus[indexPath.row]
            }
            
            let model = StatusCellModel(
                contestId: contestId, submission: currentSubmission, formatterRef: relativeTimeFormatter)
            statusCell.configure(with: model, theme: context?.preferences.selectedTheme ?? .light)
            
            tableView.tableFooterView?.isHidden = true
            return statusCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        spinner.startAnimating()
        spinner.frame = CGRect(
            x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
        
        
        let segIndex = SegmentsNames(rawValue: self.segmentIndicator.selectedSegmentIndex)!
        
        switch segIndex {
        case .standings:
            if searchBarIsEmpty() {
                if indexPath.row == ranklistRows.count - 1 && shouldFetchStandings {
                    fetchStandings(offset: ranklistRows.count + 1, count: 30, currentSearchQuery.split(separator: ",").map(String.init))
                }
            } else {
                if indexPath.row == filteredRanklistRows.count - 1 && shouldFetchStandings {
                    fetchStandings(offset: filteredRanklistRows.count + 1, count: 30,
                                   currentSearchQuery.split(separator: ",").map(String.init))
                }
                tableView.tableFooterView?.isHidden = true
            }
            
        case .status:
            if searchBarIsEmpty() {
                if indexPath.row == contestStatus.count - 1 && shouldFetchStatus {
                    fetchStatus(offset: contestStatus.count + 1, count: 30, currentSearchQuery)
                }
            } else {
                if indexPath.row == filteredContestStatus.count - 1 && shouldFetchStatus {
                    fetchStatus(offset: filteredContestStatus.count + 1, count: 30, currentSearchQuery)
                }
                tableView.tableFooterView?.isHidden = true
            }
            
        case .tasks:
            tableView.tableFooterView?.isHidden = true
        }
    }
    
    func filterRowsForSearchedText(_ searchText: String) {
        let segIndex = SegmentsNames(
            rawValue: self.segmentIndicator.selectedSegmentIndex)!
        
        switch segIndex {
        case .tasks:
            filteredContestProblems = contestProblems.filter({( model : Problem) -> Bool in
                return model.name.lowercased().contains(searchText.lowercased())
            })
        case .status:
            var charset = CharacterSet.punctuationCharacters
            charset.remove("_")
            
            if currentSearchQuery.lowercased().rangeOfCharacter(from: charset) == nil {
                fetchStatus(offset: 1, count: 30, currentSearchQuery)
            } else {
                self.present(alertHandleError, animated: true)
            }
            
        case .standings:
            fetchStandings(offset: 1, count: 30, currentSearchQuery.split(separator: ",").map(String.init))
        }
        tableView.reloadData()
    }
    
}

// -MARK: Delegate
extension ContestInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segIndex = SegmentsNames(
            rawValue: self.segmentIndicator.selectedSegmentIndex)!
        
        switch segIndex {
        case .standings:
            let currentStanding: RanklistRow
            let tasks: [Problem]
            
            if (currentSearchQuery.isEmpty) {
                currentStanding = ranklistRows[indexPath.row]
                tasks = contestProblems
            } else {
                currentStanding = filteredRanklistRows[indexPath.row]
                tasks = contestProblems
            }
            
            let nextVC =
                StoryboardScene.UserContestStatusViewController.userContestStatusViewController.instantiate()
            
            nextVC.configure(contestId: String(contestId), ranklistRow: currentStanding, tasks: tasks)
            nextVC.context = context
            
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case .tasks:
            let currentTask: Problem
            
            if searchBarIsEmpty() {
                currentTask = contestProblems[indexPath.row]
            } else {
                currentTask = filteredContestProblems[indexPath.row]
            }
            
            let model = TaskCellModel(
                contestId: String(contestId), name: currentTask.name, tags: currentTask.tags, solvedCount: nil, index: currentTask.index, rejectedAttemptCount: nil, points: nil)
            
            
            let nextVC =
                StoryboardScene.ProblemViewController.problemViewController.instantiate()
            
            navigationController?.pushViewController(nextVC, animated: true)
            nextVC.configure(with: model)
            
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ContestInfoViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let segIndex = SegmentsNames(
            rawValue: self.segmentIndicator.selectedSegmentIndex)!
        
        switch segIndex {
        case .standings, .status:
            break
        case .tasks:
            if let term = searchController.searchBar.text {
                self.currentSearchQuery = term
                filterRowsForSearchedText(term)
                tableView.reloadData()
            }
        }
    }
}

extension ContestInfoViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldFetchStatus = true
        shouldFetchStandings = true
        searchBar.text? = ""
        currentSearchQuery = ""
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let term = searchController.searchBar.text {
            self.currentSearchQuery = term
            filteredRanklistRows.removeAll()
            filteredContestStatus.removeAll()
            filteredContestProblems.removeAll()
            filterRowsForSearchedText(term)
        }
    }
}
