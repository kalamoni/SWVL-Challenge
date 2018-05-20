//
//  Station.swift
//  SWVL Challenge
//
//  Created by Mohamed Saeed on 5/19/18.
//  Copyright © 2018 kalamoni. All rights reserved.
//

import Foundation

struct Station: Codable {
    let id: Int
    let name: String
    let imgUrl: String
    let address: String
    let location: Location
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case imgUrl = "img_url"
        case address
        case location
    }
    
}
