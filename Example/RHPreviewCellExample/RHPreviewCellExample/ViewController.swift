import UIKit
import RHPreviewCell

class ViewController: UIViewController {
    
    fileprivate let reuseCellIdentifier = "RHPreviewCell_id"
    fileprivate let mockModel: RHMockCellsModel
    
    init(withMock mock: RHMockCellsModel) {
        mockModel = mock
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func loadView() {
        view = MainControllerView()
    }
    
    fileprivate func castView() -> MainControllerView {
        return view as! MainControllerView
    }
    
    func setupTableView() {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(RHPreviewTableViewCell.classForCoder(), forCellReuseIdentifier: reuseCellIdentifier)
        
        castView().set(tableView: tableView)
    }
    
    fileprivate func pushNextViewController() {
        let nextVC = NextViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    fileprivate func presentDetailsViewController(withImage image: UIImage) {
        let detailsVC = DetailsViewController(withImage: image)
        let dismissButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDetailController))
        let navController = UINavigationController(rootViewController: detailsVC)
        detailsVC.navigationItem.rightBarButtonItem = dismissButton
        
        present(navController, animated: true, completion: nil)
    }
    
    @objc fileprivate func dismissDetailController() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        pushNextViewController()
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockModel.cells.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(65)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier) as! RHPreviewTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.delegate = self
        cell.dataSource = self
        cell.textLabel?.text = mockModel.cells[indexPath.row].title
        cell.textLabel?.font = UIFont(name: "Didot", size: 20)
        
        return cell
    }
}

extension ViewController: RHPreviewCellDelegate {
    
    func previewCell(_ cell: RHPreviewTableViewCell, didSelectTileAtIndex indexValue: RHTappedTileIndexValue) {
        let cellIndex = castView().tableView.indexPath(for: cell)!.row
        
        switch indexValue {
        case .tileTapped(let index):
            print("😲 \(index) has been selected")
            
            let tiles = mockModel.cells[cellIndex].tiles
            let tileItem = tiles[index]
            
            presentDetailsViewController(withImage: tileItem.image)
        case .fingerReleased:
            print("🖖🏽 Finger has been relesed")
        }
    }
}

extension ViewController: RHPreviewCellDataSource {
    
    func previewCellNumberOfTiles(_ cell: RHPreviewTableViewCell) -> Int {
        let cellIndex = castView().tableView.indexPath(for: cell)!.row
        let tiles = mockModel.cells[cellIndex].tiles
        
        return tiles.count
    }
    
    func previewCell(_ cell: RHPreviewTableViewCell, tileForIndex: Int) -> RHPreviewTileView {
        let cellIndex = castView().tableView.indexPath(for: cell)!.row
        let tiles = mockModel.cells[cellIndex].tiles
        let tileItem = tiles[tileForIndex]
        
        let tile = RHPreviewTileView(frame: CGRect.zero)
        tile.image = tileItem.image
        
        return tile
    }
}
