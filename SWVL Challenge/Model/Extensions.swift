//
//  Extensions.swift
//  SWVL Challenge
//
//  Created by Mohamed Saeed on 5/20/18.
//  Copyright © 2018 kalamoni. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /**
     SWVL custom red color (RGBA: 235, 67, 78, 1).
     */
    @nonobjc static var SWVLRed: UIColor {
        return UIColor(red: 235/255, green: 67/255, blue: 78/255, alpha: 1)
    }
    
    /**
     SWVL custom red color (RGBA: 235, 67, 78, 1).
     */
    @nonobjc static var SWVLBookmark: UIColor {
        return UIColor(red: 253/255, green: 94/255, blue: 84/255, alpha: 1)
    }
    /**
     SWVL custom grey color (RGBA: 235, 67, 78, 1).
     */
    @nonobjc static var SWVLGray: UIColor {
        return UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
    }
    
    /**
     SWVL custom grey color (RGBA: 235, 67, 78, 1).
     */
    @nonobjc static var SWVLLightGray: UIColor {
        return UIColor(red: 139/255, green: 139/255, blue: 139/255, alpha: 1)
    }
}

extension Notification.Name {
    static let FetchedLines = Notification.Name("FetchedLinesNotifcation")
}

