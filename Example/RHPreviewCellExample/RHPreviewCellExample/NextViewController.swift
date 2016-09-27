//
//  NextViewController.swift
//  RHPreviewCell
//
//  Created by Robert Herdzik on 25/09/2016.
//  Copyright © 2016 Robert. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        view = NextView()
    }
    
    func castView() -> NextView {
        return view as! NextView
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

class NextView: UIView {

    let loadSpinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    init() {
        super.init(frame: CGRectZero)
        
        backgroundColor = UIColor.whiteColor()
        
        addSubview(loadSpinner)
        loadSpinner.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        loadSpinner.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        loadSpinner.center = center
    }
}
