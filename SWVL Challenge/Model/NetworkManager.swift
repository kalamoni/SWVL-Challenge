//
//  NetworkManager.swift
//  SWVL Challenge
//
//  Created by Mohamed Saeed on 5/19/18.
//  Copyright © 2018 kalamoni. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private init(){
    }
    
    /**
     This method is used to retrieve an image URL over the netwrok, and calls a handler upon completion.
     */
    func fetchImage(withURL imgURL: String, completionHandler: @escaping (_ success: Bool, _ img: UIImage?) -> Void) {
        
        let urlAPI = URL(string: imgURL)
        
        guard let url = urlAPI else {
            completionHandler(false, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completionHandler(false, nil)
                print("Error fetching image: \(error.localizedDescription)")
            } else if let imageData = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                let img: UIImage? = UIImage(data: imageData) ?? nil
                if let finalImage = img {
                    completionHandler(true, finalImage)
                } else {
                    completionHandler(false, nil)
                    print("Error creating image: unresolved error")
                }
            }
            }.resume()
    }
    
    
    /**
     This method is used to retrieve an image URL over the netwrok, and calls a handler upon completion.
     */
    func bookmarkStation(withID id: String, completionHandler: @escaping (_ success: Bool) -> Void) {
        
        let urlAPI = URL(string: "http://private-ab8af-swvl.apiary-mock.com/station/\(id)/bookmark")
        
        guard let url = urlAPI else {
            completionHandler(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 60
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completionHandler(false)
                print("Error bookmarking station: \(error.localizedDescription)")
            } else if let data = data {
                print(data)
                completionHandler(true)
            } else {
                completionHandler(false)
                print("Error bookmarking station: unresolved error")
            }
            }.resume()
    }
    
}
