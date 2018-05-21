//
//  Model.swift
//  SWVL Challenge
//
//  Created by Mohamed Saeed on 5/19/18.
//  Copyright © 2018 kalamoni. All rights reserved.
//

import Foundation



struct Line: Codable{
    let name: String
    let stations: [Station]
}

struct LinesList: Codable {
    let lines: [Line]
}

class Lines {
    
    private let LinesAPI = "http://private-ab8af-swvl.apiary-mock.com/lines"
    
    var linesList = LinesList(lines: []) {
        didSet {
            NotificationCenter.default.post(name: .FetchedLines, object: nil)
        }
    }
    static let shared = Lines()
    
    private init() {
        
    }
    
    /**
     This method is used to fetch the lines over the network.
     */
    func fetchLines() {
        var dataTask: URLSessionDataTask?
        let urlAPI = URL(string: LinesAPI)
        
        guard let url = urlAPI else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        
        dataTask?.cancel()
        dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            defer { dataTask = nil }
            
            if let error = error {
                print("Lines API error: \(error.localizedDescription)")
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                do {
                    let decoder = JSONDecoder()
                    self.linesList = try decoder.decode(LinesList.self, from: data)
                }
                catch {
                    print("Error parsing lines json: \(error.localizedDescription)")
                }
            }
        }
        dataTask?.resume()
    }
}



