import UIKit

class TasksViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var headerview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TaskCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TasksViewController.reuseID)
    }
    
}

extension TasksViewController: UITableViewDataSource {
    static let reuseID = "TaskCellID"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 400
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksViewController.reuseID, for: indexPath) as! TaskCell //for what??
        return cell
    }
    
}

extension TasksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerview
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0//40
    }
}
