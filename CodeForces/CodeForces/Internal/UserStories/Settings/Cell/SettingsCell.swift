import UIKit
import Reusable

class SettingsCell: UITableViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    
    let theme = ThemeManager(preferences: Preferences())
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with name: String) {
        cellLabel.text = name
        cellLabel.textColor = theme.currentTheme.cellTitleColor
        contentView.backgroundColor = theme.currentTheme.cellColor
        backgroundColor = theme.currentTheme.cellColor
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = theme.currentTheme.highlightedCellColor
        selectedBackgroundView = bgColorView
    }
}

extension SettingsCell: NibReusable { }

