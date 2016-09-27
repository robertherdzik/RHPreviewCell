import UIKit
import RHPreviewCell

class ViewController: UIViewController {
    
    private let reuseCellIdentifier = "RHPreviewCell_id"
    private let mockModel: RHMockCellsModel
    
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
    
    private func castView() -> MainControllerView {
        return view as! MainControllerView
    }
    
    func setupTableView() {
        let tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(RHPreviewTableViewCell.classForCoder(), forCellReuseIdentifier: reuseCellIdentifier)
        
        castView().set(tableView: tableView)
    }
    
    private func pushNextViewController() {
        let nextVC = NextViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func presentDetailsViewController(withImage image: UIImage) {
        let detailsVC = DetailsViewController(withImage: image)
        let dismissButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(dismiss))
        let navController = UINavigationController(rootViewController: detailsVC)
        detailsVC.navigationItem.rightBarButtonItem = dismissButton
        
        presentViewController(navController, animated: true, completion: nil)
    }
    
    @objc private func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        pushNextViewController()
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockModel.cells.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(65)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseCellIdentifier) as! RHPreviewTableViewCell
        cell.accessoryType = .DisclosureIndicator
        cell.delegate = self
        cell.dataSource = self
        cell.textLabel?.text = mockModel.cells[indexPath.row].title
        
        return cell
    }
}

extension ViewController: RHPreviewCellDelegate {
    
    func previewCell(cell: RHPreviewTableViewCell, didSelectTileAtIndex indexValue: RHTappedTileIndexValue) {
        let cellIndex = castView().tableView.indexPathForCell(cell)!.row
        
        switch indexValue {
        case .TileTapped(let index):
            print("😲 \(index) has been selected")
            
            let tiles = mockModel.cells[cellIndex].tiles
            let tileItem = tiles[index]
            
            presentDetailsViewController(withImage: tileItem.image)
        case .FingerReleased:
            print("🖖🏽 Finger has been relesed")
        }
    }
}

extension ViewController: RHPreviewCellDataSource {
    
    func previewCellNumberOfTiles(cell: RHPreviewTableViewCell) -> Int {
        let cellIndex = castView().tableView.indexPathForCell(cell)!.row
        let tiles = mockModel.cells[cellIndex].tiles
        
        return tiles.count
    }
    
    func previewCell(cell: RHPreviewTableViewCell, tileForIndex: Int) -> RHPreviewTileView {
        let cellIndex = castView().tableView.indexPathForCell(cell)!.row
        let tiles = mockModel.cells[cellIndex].tiles
        let tileItem = tiles[tileForIndex]
        
        let tile = RHPreviewTileView(frame: CGRectZero)
        tile.image = tileItem.image
        
        return tile
    }
}
