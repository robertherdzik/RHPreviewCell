import UIKit

class MainControllerView: UIView {
    
    var tableView: UITableView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.frame = bounds
    }
    
    func set(tableView: UITableView) {
        self.tableView = tableView
        
        addSubview(self.tableView)
    }
}
