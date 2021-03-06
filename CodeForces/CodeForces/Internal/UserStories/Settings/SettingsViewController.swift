import UIKit

private struct TableData {
    
    let data: [SectionData]
    
    init() {
        let themeRowType = RowType.theme(allCases: [.light, .dark])
        let section1 = SectionData(title: Theme.title, rowData: themeRowType)
        let cacheTimeRowType = RowType.cacheTime(allCases: [.never, .oneDay, .twoDays, .threeDays, .week])
        let section2 = SectionData(title: CacheTime.title, rowData: cacheTimeRowType)
        self.data = [section1, section2]
    }
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var context: Context?
    
    private var selectedTheme = Theme.light
    private var selectedCacheTime = CacheTime.oneDay
    
    private lazy var tableData = TableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: SettingsCell.self)
        
        subscribeOnThemeChange()
        applyTheme()
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
            tableView.separatorColor = context.preferences.selectedTheme.separatorColor
            
            selectedTheme = context.preferences.selectedTheme
            selectedCacheTime = context.preferences.selectedCacheTime
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.data.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableData.data[section].title
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableData.data[section].rowData {
        case .theme(let rows):
            return rows.count
        case .cacheTime(let rows):
            return rows.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SettingsCell
        switch tableData.data[indexPath.section].rowData {
        case .theme(let rows):
            let model = rows[indexPath.row].title
            cell.configure(with: model, theme: context?.preferences.selectedTheme ?? .light)
            if selectedTheme.index == indexPath.row {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        case .cacheTime(let rows):
            let model = rows[indexPath.row].title
            cell.configure(with: model, theme: context?.preferences.selectedTheme ?? .light)
            if selectedCacheTime.rawValue == indexPath.row {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch tableData.data[indexPath.section].rowData {
        case .theme:
            let prevCell = tableView.cellForRow(
                at: IndexPath(row: selectedTheme.index, section: indexPath.section))
            prevCell?.accessoryType = .none
            
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            
            selectedTheme = Theme(index: indexPath.row)
            context?.preferences.selectedTheme = selectedTheme
        case .cacheTime:
            let prevCell = tableView.cellForRow(
                at: IndexPath(row: selectedCacheTime.rawValue, section: indexPath.section))
            prevCell?.accessoryType = .none
            
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            
            selectedCacheTime = CacheTime(rawValue: indexPath.row)!
            context?.preferences.selectedCacheTime = selectedCacheTime
        }
    }
}
