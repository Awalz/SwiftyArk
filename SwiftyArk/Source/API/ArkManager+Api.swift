//
//  ArkDataManager.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-16.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

/// :nodoc:
internal extension ArkManager {
    
    /// :nodoc:
    internal func makeNetworkRequest(url: URL, completionHandler: @escaping(_ error: Error?, _ data: Data?) -> ()) {
                
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(10)
        configuration.timeoutIntervalForResource = TimeInterval(10)
        let session = URLSession(configuration: configuration)
        
        session.dataTask(with: url) { (data, response, error) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            completionHandler(nil, data)
            }.resume()
    }
    
    /// :nodoc:
    internal func fetch<T : Decodable>(_ type: T.Type, from url: URL, completionHandler: @escaping(_ error: Error?, _ data: T?) -> ()) {
        makeNetworkRequest(url: url) { (error, data) in
            if let aError = error {
                completionHandler(aError, nil)
            } else if let aData = data {
                do {
                    let myStruct = try JSONDecoder().decode(T.self, from: aData)
                    completionHandler(nil, myStruct)
                }
                catch let error {
                    completionHandler(error, nil)
                    return
                }
            }
        }
    }
}



