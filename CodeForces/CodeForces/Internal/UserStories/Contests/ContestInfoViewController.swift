//
//  ContestInfoViewController.swift
//  CodeForces
//
//  Created by Andrey Mityulin on 29.07.2018.
//  Copyright © 2018 students. All rights reserved.
//

import UIKit

private enum segmentsNames: Int {
    case tasks = 0
    case status
    case standings
}

class ContestInfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var segmentIndicator: UISegmentedControl!
    
    //TODO: make array conform to Problems Wrapper
    private var contestProblems: [Problem] = []
    private var contestStatus: [Submission] = []
    var contestId = 0
    
    private var contestProvider = ContestProvider()
    private var problemSetProvider = ProblemSetProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCellReuseID")
        
        problemSetProvider.problems(tags: nil, problemsetName: nil, {
            result in
            switch result {
            case .success(let list):
                self.contestProblems = list.problems.compactMap({$0.contestId == self.contestId ? $0 : nil})
                self.contestProblems.sort(by: {return $0.index < $1.index})
            case .error(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        contestProvider.contestStatus(contestId: contestId, handle: nil, from: 1, count: 20, {
            result in
            switch result {
            case .success(let list):
                self.contestStatus = list.compactMap({ $0 })
            case .error(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    // -MARK: Actions
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
}

// -MARK: Data Source
extension ContestInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contestProblems.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCellReuseID", for: indexPath) as! TaskCell
        
        let segIndex = segmentsNames(rawValue: segmentIndicator.selectedSegmentIndex)!
        
        switch segIndex {
        case .tasks:
            cell.taskName.text = contestProblems[indexPath.row].name
            cell.letterTask.text = contestProblems[indexPath.row].index
            cell.tags.text = contestProblems[indexPath.row].tags.joined(separator: ", ")
        case .status, .standings:
            break
        }
        return cell
    }
}

// -MARK: Delegate
extension ContestInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
}
