//
//  RHPreviewTableViewCellTilesAnimationProtocol.swift
//  RHPreviewCell
//
//  Created by Robert Herdzik on 25/09/2016.
//  Copyright © 2016 Robert. All rights reserved.
//

protocol RHPreviewTableViewCellTilesAnimationProtocol {
    func performShowAnimation(tiles tiles: [RHPreviewTileView], completion: RHTilesAnimationComplitionBlock)
    func performHideAnimation(tiles tiles: [RHPreviewTileView], completion: RHTilesAnimationComplitionBlock)
    func performMagnifyAnimation(tile tile: RHPreviewTileView)
}
