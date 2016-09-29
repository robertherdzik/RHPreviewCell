//
//  RHPreviewTilesContainerView.swift
//  RHPreviewCell
//
//  Created by Robert Herdzik on 25/09/2016.
//  Copyright © 2016 Robert. All rights reserved.
//

import UIKit

typealias RHTilesAnimationComplitionBlock = ()->()

public enum RHTappedTileIndexValue {
    case TileTapped(Int)
    case FingerReleased
}

public protocol RHPreviewCellDelegate: class {
   func previewCell(cell: RHPreviewTableViewCell, didSelectTileAtIndex indexValue: RHTappedTileIndexValue)
}

public protocol RHPreviewCellDataSource: class {
    func previewCellNumberOfTiles(cell: RHPreviewTableViewCell) -> Int
    func previewCell(cell: RHPreviewTableViewCell, tileForIndex: Int) -> RHPreviewTileView
}


class RHPreviewTilesContainerView: UIView {
    private let tilesAnimator: RHPreviewTableViewCellTilesAnimator
    private var tiles = [RHPreviewTileView]()

    var selectedTileIndex = -1 {
        didSet(oldValue) {
            if (oldValue >= 0) {
                tiles[oldValue].transform = CGAffineTransformIdentity
            }
            
            if oldValue != selectedTileIndex && selectedTileIndex >= 0 {
                performMagnify(tiles[selectedTileIndex])
            }
        }
    }

    override convenience init(frame: CGRect) {
        let tileAnimator = RHPreviewTableViewCellTilesAnimator()
        
        self.init(frame: frame, tilesAnimator: tileAnimator)
    }
    
    init(frame: CGRect, tilesAnimator: RHPreviewTableViewCellTilesAnimator) {
        self.tilesAnimator = tilesAnimator
        
        super.init(frame: frame)
        
        addTilesAsSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutTiles()
    }
    
    func reloadTiles(withNew newTiles: [RHPreviewTileView]) {
        removeTilesFromSuperview()
        tiles.removeAll()
        
        tiles = newTiles
        addTilesAsSubview()
    }
    
    func gestureOffset(point: CGPoint) {
        // If tile has not been found it means that user finger wasn't above one of tile, we treat this situation as a 'Cancel'
        guard let tile = getTileFrom(point: point) else {
            selectedTileIndex = -1
            return
        }
        
        selectedTileIndex = getIndex(of: tile)
    }
    
    func hideElements(completion: RHTilesAnimationComplitionBlock) {
        tilesAnimator.performHideAnimation(tiles: tiles, completion: completion)
    }
    
    func showElements(completion: RHTilesAnimationComplitionBlock) {
        let completionBlock = { [weak self] in
            self?.resetPresenterState()
            completion()
        }
        
        tilesAnimator.performShowAnimation(tiles: tiles, completion: completionBlock)
    }
}

private extension RHPreviewTilesContainerView {
    
    func addTilesAsSubview() {
        _ = tiles.map {
            addSubview($0)
            $0.hidden = true
            $0.alpha = 0
        }
    }
    
    func removeTilesFromSuperview() {
        _ = tiles.map { $0.removeFromSuperview() }
    }
    
    func layoutTiles() {
        let horizontalSpacing = CGFloat(2)
        let tileOffset = CGFloat(-4)
        var prevTileMaxX = horizontalSpacing
        for tile in tiles {
            let tileBorderSize = bounds.height + tileOffset
            let frame = CGRect(x: prevTileMaxX, y: -tileOffset/2, width: tileBorderSize, height: tileBorderSize)
            tile.frame = frame
            
            prevTileMaxX = tile.frame.maxX + horizontalSpacing
        }
    }
    
    func getTileFrom(point point: CGPoint) -> RHPreviewTileView? {
        var resultTile: RHPreviewTileView?
        
        for tile in tiles {
            tile.setSeleted(false)
            
            let convertedRect = convertRect(tile.frame, toView: self)
            if CGRectContainsPoint(convertedRect, point) {
                tile.setSeleted(true)
                resultTile = tile
            }
        }
        
        return resultTile
    }
    
    func performMagnify(tile: RHPreviewTileView) {
        tilesAnimator.performMagnifyAnimation(tile: tile)
    }
    
    func getIndex(of tile: RHPreviewTileView) -> Int {
        return tiles.indexOf(tile) ?? 0
    }
    
    func resetPresenterState() {
        selectedTileIndex = -1
    }
}
