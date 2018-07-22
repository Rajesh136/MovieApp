//
//  APIManager.swift
//  MovieApp
//
//  Created by techno krishna on 21/07/18.
//  Copyright © 2018 techno krishna. All rights reserved.
//

import Foundation

protocol APIManagerProtocol {
    func getDataFromServer(urlString:String, completion:@escaping (Any?)->Void)
}

class MoviesListAPI:APIManagerProtocol {
    
   static let shared = MoviesListAPI()
    
    func getDataFromServer(urlString: String, completion: @escaping (Any?) -> Void) {
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)
        let url = URL(string: urlString)!
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                completion(nil)
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
                completion(nil)
                return
            }
            print(json,"====")
            completion(json)
        })
        task.resume()

    }

    
    
}
