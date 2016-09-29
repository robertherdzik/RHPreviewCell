//
//  RHPreviewTableViewCellTilesAnimator.swift
//  RHPreviewCell
//
//  Created by Robert Herdzik on 25/09/2016.
//  Copyright © 2016 Robert. All rights reserved.
//

import UIKit

class RHPreviewTableViewCellTilesAnimator: RHPreviewTableViewCellTilesAnimationProtocol {
    
    func performShowAnimation(tiles tiles: [RHPreviewTileView], completion: RHTilesAnimationComplitionBlock) {
        for tile in tiles {
            tile.hidden = false
            UIView.animateWithDuration(0.3,
                                       animations: {
                                        tile.alpha = CGFloat(0.3)
            }) { _ in
                if tile == tiles.last {
                    completion()
                }
            }
        }
    }
    
    func performHideAnimation(tiles tiles: [RHPreviewTileView], completion: RHTilesAnimationComplitionBlock) {
        for tile in tiles {
            UIView.animateWithDuration(0.2,
                                       animations: {
                                        tile.alpha = CGFloat(0.0)
            }) { _ in
                tile.hidden = true
                
                if tile == tiles.last {
                    completion()
                }
            }
        }
    }
    
    func performMagnifyAnimation(tile tile: RHPreviewTileView) {
        UIView.animateWithDuration(0.5,
                                   delay: 0,
                                   usingSpringWithDamping: 0.4,
                                   initialSpringVelocity: 0.9,
                                   options: UIViewAnimationOptions.CurveEaseInOut,
                                   animations: {
                                    let scale = CGFloat(0.89)
                                    tile.transform = CGAffineTransformMakeScale(scale, scale)
            }, completion: nil)
    }
}
