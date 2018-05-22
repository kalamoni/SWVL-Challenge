//
//  BusView.swift
//  SWVL Challenge
//
//  Created by Mohamed Saeed on 5/22/18.
//  Copyright © 2018 kalamoni. All rights reserved.
//

import UIKit

class BusView: UIView {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    
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

}
