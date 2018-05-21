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
        
        var request =  URLRequest(url: url)
        request.httpMethod = "GET"
        
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
    
    
}
