//
//  RHPreviewTileView.swift
//  RHPreviewCell
//
//  Created by Robert Herdzik on 25/09/2016.
//  Copyright © 2016 Robert. All rights reserved.
//

import UIKit

protocol RHPreviewTileViewProtocol {
    var isSelected: Bool { get }
    
    func setSeleted(isSelected :Bool)
}

public class RHPreviewTileView: UIImageView {
    private(set) var isSelected = false
    
    func setSeleted(isSelected :Bool) {
        self.isSelected = isSelected
        
        alpha = isSelected ? CGFloat(1) : CGFloat(0.2)
    }
}
