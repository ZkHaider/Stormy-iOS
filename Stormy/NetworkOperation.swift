//
//  NetworkOperation.swift
//  Stormy
//
//  Created by Haider Khan on 6/14/15.
//  Copyright (c) 2015 ZkHaider. All rights reserved.
//

import Foundation


class NetworkOperation {
    
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryUrl: NSURL
    
    typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> Void
    
    init(url: NSURL) {
        self.queryUrl = url
    }
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion) {
        let request: NSURLRequest = NSURLRequest(URL: queryUrl)
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            
            // 1. Check the response status to see if GET request is successful
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                // Check status code here
                switch(httpResponse.statusCode) {
                case 200:
                    // 2. Create JSON Object here
                    let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data,
                    options: nil, error: nil) as? [String: AnyObject]
                    completion(jsonDictionary)
                default:
                    println("GET request not successful. HTTP Status Code: \(httpResponse.statusCode)")
                }
                
            } else {
                println("Error not a valid HTTP response")
            }
            
            // 2. Create JSON Object with data
            
        }.resume()
        
    }
}