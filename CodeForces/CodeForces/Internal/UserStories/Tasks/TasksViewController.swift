import UIKit

fileprivate enum SearchScope: Int {
    case tags
    case names
}

fileprivate extension SearchScope {
    var title: String {
        switch self {
        case .tags:
            return L10n.TasksVc.Searchscope.Title.tags
        case .names:
            return L10n.TasksVc.Searchscope.Title.name
        }
    }
}

class TasksViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var context: NetworkService?

    let theme = ThemeManager(preferences: Preferences())
    
    private let refreshControl = UIRefreshControl()
    private var data: [TaskCellModel] = []
    private var searchActive = false
    private var filtered: [TaskCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = nil
        tableView.backgroundColor = theme.currentTheme.backgroundColor
        
        configureTableView()
        fetchTasks()
        configureSearchController()
       
    }
}

private extension TasksViewController {
    func configureTableView() {
        tableView.separatorStyle = .none
        tableView.register(cellType: TaskCell.self)
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshTasksTable(_:)), for: .valueChanged)
    }
    
    func configureSearchController() {
        searchController.searchBar.scopeButtonTitles = [SearchScope.tags.title, SearchScope.names.title]
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        definesPresentationContext = true
    }
}

private extension TasksViewController {
    @objc private func refreshTasksTable(_ sender: Any) {
        fetchTasks()
    }
    
    func fetchTasks() {
        let request = ProblemSetProblemsRequest()
        refreshControl.beginRefreshing()
        context?.fetchProblemsetProblems(withRequestParams: request, { [weak self] result in
            guard let sself = self else { return }
            sself.refreshControl.endRefreshing()
            switch result {
            case .success(let problems): sself.updateTableView(withProblems: problems)
            case .error(let error): sself.showError(error)
            }
        })
    }
    
    func showError(_ error: Error) {
        let alertController = UIAlertController(
            title: L10n.Alert.Title.error, message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: L10n.Alert.Action.ok, style: .cancel))
        present(alertController, animated: true)
    }
    
    func updateTableView(withProblems: ProblemSetProblems) {
        data = withProblems.problems.map { problem -> TaskCellModel in
            let problemStatisticIndex = withProblems.problemStatistics.index(where: { problemStatistic -> Bool in
                return problemStatistic.contestId == problem.contestId && problemStatistic.index == problem.index
            })
            var problemStatistic: ProblemStatistics? = nil
            if let index = problemStatisticIndex {
                problemStatistic = withProblems.problemStatistics[index]
            }
            var solvedCount = ""
            if let statistic = problemStatistic {
                solvedCount = "\(statistic.solvedCount)"
            }
            
            let model = TaskCellModel(
                contestId: "\(problem.contestId ?? 0)",
                name: problem.name,
                tags: problem.tags,
                solvedCount: solvedCount,
                index: problem.index)
            
            return model
        }
        tableView.reloadData()
    }
}

extension TasksViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = SearchScope(rawValue: searchBar.selectedScopeButtonIndex)!
        
        searchBarFilter(searchBar, textDidChange: searchBar.text, scope: scope)
    }
}

extension TasksViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let scope = SearchScope(rawValue: selectedScope)!
        searchBarFilter(searchBar, textDidChange: searchBar.text, scope: scope)
    }
    
    fileprivate func searchBarFilter(_ searchBar: UISearchBar, textDidChange searchText: String?, scope: SearchScope) {
        filtered = data.filter({ model -> Bool in
            switch scope {
            case .tags:
                var flag = false
                for tag in model.tags {
                    if tag.lowercased().contains((searchText ?? "").lowercased()) {
                        flag = true
                        break
                    }
                }
                return flag
            case .names:
                return model.name?.lowercased().contains((searchText ?? "").lowercased()) ?? false
            }
        })
        self.tableView.reloadData()
    }
}

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filtered.count
        } else { return data.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TaskCell
        let model: TaskCellModel
        if searchActive {
            model = filtered[indexPath.row]
        } else { model = data[indexPath.row] }
        cell.configure(with: model)
        return cell
    }
}

extension TasksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
