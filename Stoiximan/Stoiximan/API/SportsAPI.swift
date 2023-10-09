//
//  SportsAPI.swift
//  Stoiximan
//
//  Created by Rogério Fidelix on 08/10/2023.
//

import Foundation

public class SportsAPI {
    public func fetchSports(completion: @escaping ([Sports]) -> Void) {
        guard let url = URL(string: "https://618d3aa7fe09aa001744060a.mockapi.io/api/sports") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            let decoder = JSONDecoder()
            if let data {
                do {
                    let conversion = try decoder.decode([Sports].self, from: data)
                    completion(conversion)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
