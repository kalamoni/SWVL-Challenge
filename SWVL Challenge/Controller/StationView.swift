//
//  StationView.swift
//  SWVL Challenge
//
//  Created by Mohamed Saeed on 5/19/18.
//  Copyright © 2018 kalamoni. All rights reserved.
//

import UIKit

class StationView: UIView {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var snippet: UILabel!
    @IBOutlet var bookmarkButton: UIButton!
    
    var id = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commomInit()
    }
    
    func commomInit() {
        
    }
    
    /**
     This method is used to dismiss the station's view and get back to the map view.
     
     - parameter sender: a reference to the button that has been tapped.
     */
    @IBAction func didTapDismiss(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            self.alpha = 0
        }) { (success: Bool) in
            self.transform = CGAffineTransform.identity
            self.removeFromSuperview()
        }
    }
    
}
