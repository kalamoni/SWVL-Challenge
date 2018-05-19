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
    
    @IBAction func didTapBookmark(_ sender: Any) {
        print("did tap station \(title.text ?? "-") bookmark button")
    }
    
    
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
