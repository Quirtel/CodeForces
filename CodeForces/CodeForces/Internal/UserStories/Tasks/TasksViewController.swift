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
    
    var context: Context?
    
    @IBOutlet private weak var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    private var isKeyboardShown = false
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTasksTable(_:)), for: .valueChanged)
        return refresh
    }()
    private var isFetchingData = false
    private var data: [TaskCellModel] = []
    private var isSearchActive = false {
        didSet {
            if isSearchActive == oldValue {
                return
            }
            if isSearchActive {
                removeRefreshControl()
            } else {
                addRefreshControl()
                if data.count > 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                }
            }
        }
    }
    private var filtered: [TaskCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeOnThemeChange()
        configureTableView()
        configureSearchController()
        applyTheme()
        fetchTasks(force: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(storyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(
            self, selector: #selector(storyboardDidHide), name: .UIKeyboardDidHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidHide, object: nil)
    }
    
    @objc private func storyboardWillShow(notification: Notification) {
        if isKeyboardShown {
            return
        }
        isKeyboardShown = true
        
        var adjustedContentInset: UIEdgeInsets = UIEdgeInsets()
        if #available(iOS 11.0, *) {
            adjustedContentInset = tableView.adjustedContentInset
        }
        
        guard let userInfo = notification.userInfo else { return }
        guard let value = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue) else { return }
        let keyboardFrame = view.convert(value.cgRectValue, from: nil)
        let tableViewFrame = tableView.frame
        let hiddenTableViewRect = tableViewFrame.intersection(keyboardFrame)
        let contentInsets = UIEdgeInsetsMake(0, 0, hiddenTableViewRect.size.height - adjustedContentInset.bottom, 0)

        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func storyboardDidHide(notification: Notification) {
        let contentInset = UIEdgeInsets.zero
        tableView.contentInset = contentInset
        tableView.scrollIndicatorInsets = contentInset
        isKeyboardShown = false
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
            refreshControl.tintColor = context.preferences.selectedTheme.spinnerColor
        }
    }
}

private extension TasksViewController {
    func configureTableView() {
        tableView.separatorStyle = .none
        tableView.register(cellType: TaskCell.self)
        
        addRefreshControl()
    }
    
    func configureSearchController() {
        searchController.searchBar.scopeButtonTitles = [SearchScope.tags.title, SearchScope.names.title]
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = context?.preferences.selectedTheme.selectedControlColor

        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        definesPresentationContext = true
    }
    
    func addRefreshControl() {
        tableView.addSubview(refreshControl)
    }
    
    func removeRefreshControl() {
        refreshControl.removeFromSuperview()
    }
}

private extension TasksViewController {
    @objc private func refreshTasksTable(_ sender: Any) {
        fetchTasks(force: true)
    }
    
    func fetchTasks(force: Bool) {
        let request = ProblemSetProblemsRequest()
        isFetchingData = true
        refreshControl.beginRefreshing()
        context?.contentService.fetchProblemSetProblems(withRequestParams: request, force: force, {
            [weak self] result in
            guard let sself = self else { return }
            sself.isFetchingData = false
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
                index: problem.index, rejectedAttemptCount: nil, points: nil)
            
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
        isSearchActive = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
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
        if isSearchActive {
            return filtered.count
        } else { return data.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TaskCell
        let model: TaskCellModel
        if isSearchActive {
            model = filtered[indexPath.row]
        } else { model = data[indexPath.row] }
        cell.configure(with: model, theme: context?.preferences.selectedTheme ?? .light)
        return cell
    }
}

extension TasksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = TaskCellModel(
            contestId: String(data[indexPath.row].contestId), name: data[indexPath.row].name, tags: data[indexPath.row].tags, solvedCount: nil, index: data[indexPath.row].index, rejectedAttemptCount: nil, points: nil)
        
        
        let nextVC =
            StoryboardScene.ProblemViewController.problemViewController.instantiate()
        
        navigationController?.pushViewController(nextVC, animated: true)
        
        nextVC.configure(with: model)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
