import UIKit

class ContestsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ContestCell", bundle: nil),
                           forCellReuseIdentifier: "ContestCellReuseID")
    }
}

// -MARK: Data Source
extension ContestsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContestCellReuseID",
                                                     for: indexPath) as! ContestCell
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension ContestsViewController: UITableViewDelegate {
    
}
