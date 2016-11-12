//
//  RHPreviewTableViewCellTilesAnimator.swift
//  RHPreviewCell
//
//  Created by Robert Herdzik on 25/09/2016.
//  Copyright © 2016 Robert. All rights reserved.
//

import UIKit

class RHPreviewTableViewCellTilesAnimator: RHPreviewTableViewCellTilesAnimationProtocol {
    
    func performShowAnimation(for tiles: [RHPreviewTileView], completion: @escaping RHTilesAnimationComplitionBlock) {
        for tile in tiles {
            tile.isHidden = false
            UIView.animate(withDuration: 0.3,
                                       animations: {
                                        tile.alpha = CGFloat(0.3)
            }, completion: { _ in
                if tile == tiles.last {
                    completion()
                }
            }) 
        }
    }
    
    func performHideAnimation(for tiles: [RHPreviewTileView], completion: @escaping RHTilesAnimationComplitionBlock) {
        for tile in tiles {
            UIView.animate(withDuration: 0.2,
                                       animations: {
                                        tile.alpha = CGFloat(0.0)
            }, completion: { _ in
                tile.isHidden = true
                
                if tile == tiles.last {
                    completion()
                }
            }) 
        }
    }
    
    func performMagnifyAnimation(for tile: RHPreviewTileView) {
        UIView.animate(withDuration: 0.5,
                                   delay: 0,
                                   usingSpringWithDamping: 0.4,
                                   initialSpringVelocity: 0.9,
                                   options: UIViewAnimationOptions(),
                                   animations: {
                                    let scale = CGFloat(0.89)
                                    tile.transform = CGAffineTransform(scaleX: scale, y: scale)
            }, completion: nil)
    }
}
