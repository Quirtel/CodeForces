import UIKit


class TasksViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var context: Provider?
    
    private let refreshControl = UIRefreshControl()
    private var data: [TaskCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchTasks()
    }
}

private extension TasksViewController {
    func configureTableView() {
        
        tableView.separatorStyle = .none
        tableView.register(cellType: TaskCell.self)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshTasksTable(_:)), for: .valueChanged)
    }
}

private extension TasksViewController {
    @objc private func refreshTasksTable(_ sender: Any) {
        fetchTasks()
    }
    
    func fetchTasks() {
        let request = ProblemSetProblemsRequest(tags: nil, problemsetName: nil)
        refreshControl.beginRefreshing()
        context?.problemsetProblems(withRequestParams: request, { [weak self] result in
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

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TaskCell
        let model = data[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}
