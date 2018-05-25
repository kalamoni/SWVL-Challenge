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
    private enum NetworkError: Error {
        case APISyntaxError
    }
    static let shared = NetworkManager()
    private let LinesAPI = "http://private-ab8af-swvl.apiary-mock.com/lines"
    
    private init(){
    }
    
    /**
     This method is used to fetch the lines over the network, and calls a handler upon completion.
     
     - parameter completionHandler: The completion handler to call when the load request is complete. This handler is executed on the delegate queue.
     - parameter data: An optional Data reflects the returned data from the request.
     - parameter urlResponse: An optional URLResponse reflects the request.
     - parameter error: An optional Error depends on whether the request succeeded or failed with errors.
     
     */
    func fetchLines(completionHandler: @escaping (_ data: Data?, _ urlResponse: URLResponse?, _ error: Error?) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        var dataTask: URLSessionDataTask?
        let urlAPI = URL(string: LinesAPI)
        
        guard let url = urlAPI else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            completionHandler(nil, nil, NetworkError.APISyntaxError)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        
        dataTask?.cancel()
        dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            defer { dataTask = nil }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            completionHandler(data, response, error)
        }
        dataTask?.resume()
    }
    
    /**
     This method is used to retrieve an image URL over the netwrok, and calls a handler upon completion.
     
     - parameter imgURL: A string represents the image URL.
     - parameter completionHandler: The completion handler to call when the load request is complete. This handler is executed on the delegate queue.
     - parameter success: A boolean reflects whether the fetch request succeeded or not.
     - parameter img: An optional UIImage depends on whether the fetch request succeeded or not.
     */
    func fetchImage(withURL imgURL: String, completionHandler: @escaping (_ success: Bool, _ img: UIImage?) -> Void) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let urlAPI = URL(string: imgURL)
        
        guard let url = urlAPI else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            completionHandler(false, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
     
     - parameter id: A string represents station's ID.
     - parameter completionHandler: The completion handler to call when the load request is complete. This handler is executed on the delegate queue.
     - parameter success: A boolean reflects whether the request succeeded or not.
     */
    func bookmarkStation(withID id: String, completionHandler: @escaping (_ success: Bool) -> Void) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let urlAPI = URL(string: "http://private-ab8af-swvl.apiary-mock.com/station/\(id)/bookmark")
        
        guard let url = urlAPI else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            completionHandler(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 60
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
