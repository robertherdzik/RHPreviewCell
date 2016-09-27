import UIKit

struct RHMockTileModel {
    let image: UIImage
    
    init(imageName name: String) {
        image = UIImage(named: name)!
    }
}

protocol RHMockCellModelProtocol {
    var title: String { get }
    var tiles: [RHMockTileModel] { get set }
}

struct RHMockCellModel_1: RHMockCellModelProtocol {
    let title: String = "Warsaw Photos"
    var tiles: [RHMockTileModel] = {
        var result = [RHMockTileModel]()
        for index in 1...4 {
            result.append(RHMockTileModel(imageName: "warsaw_\(index)"))
        }
        return result
    }()
}

struct RHMockCellModel_2: RHMockCellModelProtocol {
    let title: String = "Other Photos"
    var tiles: [RHMockTileModel] = {
        var result = [RHMockTileModel]()
        for index in 1...3 {
            result.append(RHMockTileModel(imageName: "other_\(index)"))
        }
        return result
    }()
}

class RHMockCellsModel {
    let cells: [RHMockCellModelProtocol] = [
        RHMockCellModel_1(),
        RHMockCellModel_2()
    ]
}

