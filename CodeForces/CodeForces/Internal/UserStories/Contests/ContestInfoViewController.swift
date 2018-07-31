import UIKit

private enum SegmentsNames: Int {
    case tasks = 0
    case status
    case standings
}

class ContestInfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var segmentIndicator: UISegmentedControl!
    
    //TODO: make array varform to Problems Wrapper
    private var contestProblems: [Problem] = []
    private var contestStatus: [Submission] = []
    private var ranklistRows: [RanklistRow] = []
    var contestId = 0
    var currentOffsetStandings = 0
    var currentOffsetStatus = 0
    
    private var contestProvider = ContestProvider()
    private var problemSetProvider = ProblemSetProvider()
    
    private var shouldFetchStandings = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(cellType: TaskCell.self)
        tableView.register(cellType: StatusCell.self)
        tableView.register(cellType: StandingsCell.self)
        
        fetchStatus(offset: 1, count: 30)
        fetchStandings(offset: 1, count: 30)
    }
    
    func fetchStatus(offset: Int, count: Int) {
        contestProvider.contestStatus(
            requestParams: ContestStatusRequest(
                contestId: contestId, handle: nil, from: offset, count: count), {
                    result in
                    switch result {
                    case .success(let list):
                        self.contestStatus.append(contentsOf: list.compactMap({ $0 }))
                    case .error(let error):
                        print(error)
                    }
        })
    }
    
    func fetchStandings(offset: Int, count: Int) {
        let segIndex = SegmentsNames(rawValue: segmentIndicator.selectedSegmentIndex)!
        
        if segIndex != .standings {
            return
        }
        
        shouldFetchStandings = false
        contestProvider.contestStandings(
            requestParams: ContestStandingsRequest(
                contestId: contestId, from: offset, count: count,
                // TODO: use weak self
                handles: nil, room: nil, showUnofficial: false), {[weak self] result in
                    
                    guard let strongSelf = self else { return }
                    
                    switch result {
                    case .success(let list):
                        strongSelf.ranklistRows.append(contentsOf: list.rows)
                        let indexPaths = Array(offset-1..<offset-1+count)
                            .map({ IndexPath(row: $0, section: 0) })
                    
                        strongSelf.tableView.setContentOffset(
                            strongSelf.tableView.contentOffset, animated: true)
                        strongSelf.tableView.insertRows(
                            at: indexPaths, with: .fade)
                    case .error(let error):
                        print(error)
                    }
                    strongSelf.shouldFetchStandings = true
        })
    }
    
    // -MARK: Actions
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        let segIndex = SegmentsNames(rawValue: segmentIndicator.selectedSegmentIndex)!
        
        switch segIndex {
        case .standings:
            if ranklistRows.count == 0 {
                fetchStandings(offset: 1, count: 30)
            }
        case .status:
            fetchStatus(offset: currentOffsetStatus + 1, count: 30)
        case .tasks:
            break
        }
        
        tableView.reloadData()
    }
    
}

// -MARK: Data Source
extension ContestInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let segIndex = SegmentsNames(rawValue: segmentIndicator.selectedSegmentIndex)!
        
        switch segIndex {
        case .standings:
            return ranklistRows.count
        case .status:
            return contestStatus.count
        case .tasks:
            return 1
        }
    }
    
    func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let segIndex = SegmentsNames(rawValue: segmentIndicator.selectedSegmentIndex)!
        
        switch segIndex {
        case .tasks:
            // -MARK: Tasks Cells
            let taskCell = tableView.dequeueReusableCell(for: indexPath) as TaskCell
            return taskCell
        case .standings:
            // -MARK: Standings Cells
            let standingsCell = tableView.dequeueReusableCell(for: indexPath) as StandingsCell
            
            let currentRanklistRow = ranklistRows[indexPath.row]
            
            var participantName = String()
            
            var participantIsTeam: Bool = false
            
            if let teamName = currentRanklistRow.party.teamName {
                participantName = teamName
                participantIsTeam = true
            } else if let handle = currentRanklistRow.party.members.first {
                participantName = handle.handle
                participantIsTeam = false
            }
            
            let model = StandingsCellModel(
                participantName: participantName, rank: currentRanklistRow.rank,
                points: currentRanklistRow.points, isTeam: participantIsTeam)
            
            standingsCell.configure(with: model)
            
            return standingsCell
            
        case .status:
            // -MARK: Status Cells
            let statusCell = tableView.dequeueReusableCell(for: indexPath) as StatusCell
            
            return statusCell
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let segIndex = SegmentsNames(rawValue: segmentIndicator.selectedSegmentIndex)!
        switch segIndex {
        case .standings:
            if indexPath.row == ranklistRows.count - 1 && shouldFetchStandings {
                let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                
                tableView.tableFooterView = spinner
                tableView.tableFooterView?.isHidden = false
                
                fetchStandings(offset: ranklistRows.count, count: 30)
            }
        case .status, .tasks:
            break
        }
        
    }
}

// -MARK: Delegate
extension ContestInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
