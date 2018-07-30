//
//  TaskCell.swift
//  CodeForces
//
//  Created by Andrey Mityulin on 29.07.2018.
//  Copyright © 2018 students. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet var taskName: UILabel!
    @IBOutlet var tags: UILabel!
    @IBOutlet var solvedCountLabel: UILabel!
    @IBOutlet var countParameter: UILabel!
    @IBOutlet var letterTask: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
