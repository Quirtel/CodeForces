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
    
    private var context = NetworkService()
    
    private var shouldFetchStandings = true
    private var shouldFetchStatus = true
    private var canEditSearchBar = true
    private var refresherPulled = false
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let alertHandleError = UIAlertController(
        title: "Ошибка",
        message: "Хэндл содержит недопустимые символы", preferredStyle: .alert)
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertHandleError.addAction(UIAlertAction(title: "OK" , style: .default,
                                                 handler: { _ in}))
        
        tableView.separatorStyle = .none
        tableView.tableFooterView = spinner
        //tableView.refreshControl = refreshControl
        tableView.addSubview(refreshControl)
        //extendedLayoutIncludesOpaqueBars = true
        
        segmentView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        segmentView.layer.borderWidth = 1
        
        navigationController?.navigationBar.isTranslucent = false
        
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
            navigationItem.searchController = searchController
            navigationItem.searchController?.searchBar.delegate = self
            navigationItem.hidesSearchBarWhenScrolling = true
        } else {
            // Fallback on earlier versions
        }
        
        setupSearchController()
        
        tableView.register(cellType: TaskCell.self)
        tableView.register(cellType: StatusCell.self)
        tableView.register(cellType: StandingsCell.self)
        
        fetchTasks()
        fetchStatus(offset: 1, count: 30, nil)
        fetchStandings(offset: 1, count: 30, nil)
    }
    
    func searchBarIsEmpty() -> Bool {
        return (searchController.searchBar.text?.isEmpty ?? true)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refresherPulled = true
        segmentValueChanged(segmentIndicator)
    }
    
    // -MARK: Fetch Tasks
    
    func fetchTasks() {
        let segIndex = SegmentsNames(rawValue: self.segmentIndicator.selectedSegmentIndex)!
        
        if segIndex != .tasks {
            return
        }
        
        context.fetchContestStandings(
            requestParams: ContestStandingsRequest(
                contestId: contestId, from: 1, count: 1,
                handles: nil, room: nil, showUnofficial: false), {[weak self] result in
                    
                    guard let strongSelf = self else { return }
                    
                    switch result {
                    case .success(let list):
                        
                        strongSelf.contestProblems = list.problems
                        
                        strongSelf.tableView.setContentOffset(
                            strongSelf.tableView.contentOffset, animated: true)
                        
                        strongSelf.spinner.isHidden = true
                        
                        strongSelf.refresherPulled = false
                        strongSelf.refreshControl.endRefreshing()
                        
                        strongSelf.tableView.reloadData()
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
        
        context.fetchContestStatus(
            requestParams: ContestStatusRequest(
                contestId: contestId, handle: handle, from: offset, count: count), { [weak self] result in
                    
                    guard let strongSelf = self else { return }
                    
                    switch result {
                    case .success(let list):
                        
                        if handle != nil {
                            if strongSelf.refresherPulled {
                                strongSelf.filteredContestStatus.removeAll()
                            }
                            
                            if !handle!.isEmpty {
                                strongSelf.filteredContestStatus.append(contentsOf: list.compactMap({ $0 }))
                            }
                        } else {
                            if strongSelf.refresherPulled {
                                strongSelf.contestStatus.removeAll()
                            }
                            
                            strongSelf.contestStatus.append(contentsOf: list.compactMap({ $0 }))
                        }
                        
                        let indexPaths = Array(offset-1..<offset-1+list.count)
                            .map({ IndexPath(row: $0, section: 0) })
                        
                        if handle != nil || strongSelf.refresherPulled {
                            strongSelf.tableView.reloadData()
                        } else {
                            strongSelf.tableView.setContentOffset(
                                strongSelf.tableView.contentOffset, animated: true)
                            
                            strongSelf.tableView.beginUpdates()
                            strongSelf.tableView.insertRows(
                                at: indexPaths, with: .fade)
                            strongSelf.tableView.endUpdates()
                        }
                        
                        strongSelf.spinner.isHidden = true
                        
                        if list.count > 0 {
                            strongSelf.shouldFetchStatus = true
                        }
                        strongSelf.refresherPulled = false
                        strongSelf.refreshControl.endRefreshing()
                    case .error(let error):
                        print(error)
                    }
        })
    }
    
    // -MARK: Fetch Standings
    func fetchStandings(offset: Int, count: Int, _ handles: [String]?) {
        
        let segIndex = SegmentsNames(rawValue: self.segmentIndicator.selectedSegmentIndex)!
        
        if segIndex != .standings {
            return
        }
        
        shouldFetchStandings = false
        context.fetchContestStandings(
            requestParams: ContestStandingsRequest(
                contestId: contestId, from: offset, count: count,
                handles: handles, room: nil, showUnofficial: false), {[weak self] result in
                    
                    guard let strongSelf = self else { return }
                    
                    switch result {
                    case .success(let list):
                        
                        if handles != nil {
                            if strongSelf.refresherPulled {
                                strongSelf.filteredRanklistRows.removeAll()
                            }
                            
                            if !handles!.isEmpty {
                                strongSelf.filteredRanklistRows.append(contentsOf: list.rows)
                            }
                        } else {
                            if strongSelf.refresherPulled {
                                strongSelf.ranklistRows.removeAll()
                            } else {
                                strongSelf.ranklistRows.append(contentsOf: list.rows)
                            }
                        }
                        
                        let indexPaths = Array(offset-1..<offset-1+list.rows.count)
                            .map({ IndexPath(row: $0, section: 0) })
                        
                        
                        if handles != nil || strongSelf.refresherPulled {
                            strongSelf.tableView.reloadData()
                        } else {
                            strongSelf.tableView.setContentOffset(
                                strongSelf.tableView.contentOffset, animated: true)
                            
                            strongSelf.tableView.beginUpdates()
                            strongSelf.tableView.insertRows(
                                at: indexPaths, with: .fade)
                            strongSelf.tableView.endUpdates()
                        }
                        
                        strongSelf.spinner.isHidden = true
                        
                        if list.rows.count > 0 {
                            strongSelf.shouldFetchStandings = true
                        }
                        strongSelf.refresherPulled = false
                        strongSelf.refreshControl.endRefreshing()
                    case .error(let error):
                        print(error)
                    }
                    
        })
    }
    
    func setupSearchController() {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        if #available(iOS 11.0, *) {
            
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.definesPresentationContext = false
    }
    
    
    // -MARK: Actions
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        let segIndex = SegmentsNames(rawValue: self.segmentIndicator.selectedSegmentIndex)!
        tableView.tableFooterView?.isHidden = false
        switch segIndex {
        case .standings:
            if (filteredRanklistRows.count == 0 && !searchBarIsEmpty()) || refresherPulled {
                fetchStandings(offset: 1, count: 30, currentSearchQuery.split(separator: ",").map(String.init))
                tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            } else if ranklistRows.count == 0 || refresherPulled {
                fetchStandings(offset: 1, count: 30, nil)
                tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        case .status:
            if (filteredContestStatus.count == 0 && !searchBarIsEmpty()) || refresherPulled {
                fetchStatus(offset: 1, count: 30, currentSearchQuery)
                tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            } else if contestStatus.count == 0 || refresherPulled {
                fetchStatus(offset: 1, count: 30, nil)
                tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        case .tasks:
            refreshControl.endRefreshing()
            if (filteredContestProblems.count == 0 && !searchBarIsEmpty()) || refresherPulled {
                filterRowsForSearchedText(currentSearchQuery)
                tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            } else if contestProblems.count >= 0 || refresherPulled {
                tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
            tableView.reloadData()
        }
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
            
            let model = TaskCellModel(contestId: String(contestId), name: currentTask.name, tags: currentTask.tags, solvedCount: nil, index: currentTask.index)
            
            taskCell.configure(with: model)
            
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
            standingsCell.configure(with: model)
            
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
            
            let model = StatusCellModel(contestId: contestId, submission: currentSubmission)
            statusCell.configure(with: model)
            
            return statusCell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        spinner.startAnimating()
        spinner.frame = CGRect(
            x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        
        tableView.tableFooterView?.isHidden = false
        
        tableView.tableFooterView = spinner
        
        let segIndex = SegmentsNames(rawValue: self.segmentIndicator.selectedSegmentIndex)!
        
        switch segIndex {
        case .standings:
            if searchBarIsEmpty() {
                if indexPath.row == ranklistRows.count - 1 && shouldFetchStandings {
                    fetchStandings(offset: ranklistRows.count + 1, count: 30, nil)
                }
            } else {
                if indexPath.row == filteredRanklistRows.count - 1 && shouldFetchStandings {
                    fetchStandings(offset: filteredRanklistRows.count + 1, count: 30,
                                   currentSearchQuery.split(separator: ",").map(String.init))
                }
            }
        case .status:
            if searchBarIsEmpty() {
                if indexPath.row == contestStatus.count - 1 && shouldFetchStatus {
                    fetchStatus(offset: contestStatus.count + 1, count: 30, nil)
                }
            } else {
                if indexPath.row == filteredContestStatus.count - 1 && shouldFetchStatus {
                    fetchStatus(offset: filteredContestStatus.count + 1, count: 30, currentSearchQuery)
                }
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
            let charset = CharacterSet.punctuationCharacters
            
            if currentSearchQuery.lowercased().rangeOfCharacter(from: charset) == nil {
                fetchStatus(offset: 1, count: 30, currentSearchQuery)
            } else {
                self.present(alertHandleError, animated: true)
            }
            
        case .standings:
            fetchStandings(offset: 1, count: 30, currentSearchQuery.split(separator: ",").map(String.init))
        }
    }
    
}

// -MARK: Delegate
extension ContestInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
