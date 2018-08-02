import UIKit
import Reusable

class SettingsCell: UITableViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    
    func configure(with name: String, theme: Theme) {
        cellLabel.text = name
        cellLabel.textColor = theme.cellTitleColor
        contentView.backgroundColor = theme.cellColor
        backgroundColor = theme.cellColor
        
        tintColor = theme.cellTintColor
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = theme.highlightedCellColor
        selectedBackgroundView = bgColorView
    }
}

extension SettingsCell: NibReusable { }

