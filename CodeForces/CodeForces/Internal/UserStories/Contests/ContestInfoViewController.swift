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
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        tableView.tableFooterView = spinner
        
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
        
        fetchStatus(offset: 1, count: 30, nil)
        fetchStandings(offset: 1, count: 30, nil)
    }
    
    func searchBarIsEmpty() -> Bool {
        return (searchController.searchBar.text?.isEmpty ?? true)
    }
    
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
                            if !handle!.isEmpty {
                                strongSelf.filteredContestStatus.append(contentsOf: list.compactMap({ $0 }))
                            }
                        } else {
                            strongSelf.filteredContestStatus.removeAll()
                            strongSelf.contestStatus.append(contentsOf: list.compactMap({ $0 }))
                        }
                        
                        let indexPaths = Array(offset-1..<offset-1+list.count)
                            .map({ IndexPath(row: $0, section: 0) })
                        
                        strongSelf.tableView.setContentOffset(
                            strongSelf.tableView.contentOffset, animated: true)
                        
                        if handle != nil {
                            strongSelf.tableView.reloadData()
                        } else {
                            strongSelf.tableView.insertRows(
                                at: indexPaths, with: .fade)
                        }
                        
                        strongSelf.spinner.isHidden = true
                        
                        if list.count > 0 {
                            strongSelf.shouldFetchStatus = true
                        }
                        
                    case .error(let error):
                        print(error)
                    }
                    
        })
    }
    
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
                            if !handles!.isEmpty {
                                strongSelf.filteredRanklistRows.append(contentsOf: list.rows)
                            }
                        } else {
                            strongSelf.ranklistRows.append(contentsOf: list.rows)
                        }
                        
                        let indexPaths = Array(offset-1..<offset-1+list.rows.count)
                            .map({ IndexPath(row: $0, section: 0) })
                        
                        strongSelf.tableView.setContentOffset(
                            strongSelf.tableView.contentOffset, animated: true)
                        
                        if handles != nil {
                            strongSelf.tableView.reloadData()
                        } else {
                            strongSelf.tableView.insertRows(
                                at: indexPaths, with: .fade)
                        }
                        
                        strongSelf.spinner.isHidden = true
                        
                        if list.rows.count > 0 {
                            strongSelf.shouldFetchStandings = true
                        }
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
            if filteredRanklistRows.count == 0 && !searchBarIsEmpty() {
                fetchStandings(offset: 1, count: 30, currentSearchQuery.split(separator: ",").map(String.init))
                tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                return
            }
            
            if ranklistRows.count == 0 {
                fetchStandings(offset: 1, count: 30, nil)
                tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        case .status:
            if filteredContestStatus.count == 0 && !searchBarIsEmpty() {
                fetchStatus(offset: 1, count: 30, currentSearchQuery)
                tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
            
            if contestStatus.count == 0 {
                fetchStatus(offset: 1, count: 30, nil)
                tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        case .tasks:
            break
        }
        
        tableView.reloadData()
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
            return 1
        }
    }
    
    func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let segIndex = SegmentsNames(rawValue: self.segmentIndicator.selectedSegmentIndex)!
        
        switch segIndex {
        case .tasks:
            // -MARK: Tasks Cells
            let taskCell = tableView.dequeueReusableCell(for: indexPath) as TaskCell
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
            fetchStatus(offset: 1, count: 30, currentSearchQuery)
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
            }
        }
    }
}

extension ContestInfoViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldFetchStatus = true
        shouldFetchStandings = true
        searchBar.text?.removeAll()
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
