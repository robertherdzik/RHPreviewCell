//
//  RHPreviewTableViewCell.swift
//  RHPreviewCell
//
//  Created by Robert Herdzik on 25/09/2016.
//  Copyright © 2016 Robert. All rights reserved.
//

import UIKit

public class RHPreviewTableViewCell: UITableViewCell {
    private var tilesManagerView: RHPreviewTilesContainerView!
    
    public weak var delegate: RHPreviewCellDelegate?
    public weak var dataSource: RHPreviewCellDataSource?
    
    var pressDuration = CFTimeInterval(0.4)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addGesture()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fulfilTilesContent() {
        guard let numberOfTiles = dataSource?.previewCellNumberOfTiles(self) else {
            assertionFailure("previewCellNumberOfTiles not implemented 😥")
            return
        }
        
        var newTiles = [RHPreviewTileView]()
        for index in 0...numberOfTiles - 1 {
            if let tile = dataSource?.previewCell(self, tileForIndex: index) {
                newTiles.append(tile)
            }
        }
        
        tilesManagerView.reloadTiles(withNew: newTiles)
    }
    
    private func addGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(triggerLongPress))
        longPressGesture.minimumPressDuration = pressDuration
        
        contentView.addGestureRecognizer(longPressGesture)
    }
    
    private func creteTilesPresenterIfNecessary() {
        if tilesManagerView != nil { return }
        
        tilesManagerView = RHPreviewTilesContainerView(frame: bounds)
        tilesManagerView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.15)
        contentView.addSubview(tilesManagerView!)
        
        fulfilTilesContent()
    }
    
    private func showTiles(completion: RHTilesAnimationComplitionBlock) {
        tilesManagerView.hidden = false
        tilesManagerView.showElements(completion)
    }
    
    private func hideTiles() {
        tilesManagerView.hideElements { [weak self] in self?.tilesManagerView.hidden = true }
    }
    
    private func passFingerPositionToPresenter(from recognizer: UILongPressGestureRecognizer) {
        let fingerPosition = recognizer.locationInView(contentView)
        tilesManagerView.gestureOffset(fingerPosition)
    }
    
    private func getSelectedTileIndexValue() -> RHTappedTileIndexValue {
        if tilesManagerView.selectedTileIndex < 0 {
            return RHTappedTileIndexValue.FingerReleased
        } else {
            return RHTappedTileIndexValue.TileTapped(tilesManagerView.selectedTileIndex)
        }
    }
    
    func triggerLongPress(recognizer: UILongPressGestureRecognizer) {
        creteTilesPresenterIfNecessary()
        
        switch recognizer.state {
        case .Began:
            showTiles { [weak self] in self?.passFingerPositionToPresenter(from: recognizer) }
        case .Changed:
            passFingerPositionToPresenter(from: recognizer)
        case .Cancelled, .Ended, .Failed:
            
            delegate?.previewCell(self, didSelectTileAtIndex: getSelectedTileIndexValue())
            hideTiles()
            
        default:
            print("default")
        }
    }
}
