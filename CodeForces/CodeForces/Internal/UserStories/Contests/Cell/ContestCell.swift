//
//  ContestCell.swift
//  CodeForces
//
//  Created by Андрей Митюлин on 27.07.2018.
//  Copyright © 2018 students. All rights reserved.
//

import UIKit

class ContestCell: UITableViewCell {
    @IBOutlet var contestName: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var durationTime: UILabel!
    @IBOutlet var endTime: UILabel!
    @IBOutlet var remainingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
