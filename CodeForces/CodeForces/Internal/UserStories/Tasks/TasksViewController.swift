import UIKit

class TasksViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
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

extension TasksViewController {
    @objc private func refreshTasksTable(_ sender: Any) {
        fetchTasks()
    }
    func fetchTasks() { }
}

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TaskCell

        return cell
    }
}
