//
//  ArkDataManager.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-16.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation
import SystemConfiguration


/// :nodoc:
internal extension ArkManager {
    
    /// :nodoc:
    internal func makeNetworkRequest(url: URL, completionHandler: @escaping(_ error: Error?, _ data: Data?) -> ()) {
        
        guard isConnectedToNetwork() == true else {
            completionHandler(ApiError.networkError, nil)
            return
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(10)
        configuration.timeoutIntervalForResource = TimeInterval(10)
        let session = URLSession(configuration: configuration)
        
        session.dataTask(with: url) { (data, response, error) in
            if let aError = error {
                DispatchQueue.main.async {
                    completionHandler(aError, nil)
                }
                return
            }
            DispatchQueue.main.async {
                completionHandler(nil, data)
            }
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
    
    /// :nodoc:
    internal func jsonFrom(_ data: Data?) -> [String: AnyObject]? {
        
        guard let jsonData = data else {
            return nil
        }
        
        if let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: AnyObject] {
            return jsonDict
        } else if let jsonArray = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? NSArray {
            guard let jarray = jsonArray else {
                return nil
            }
            return jarray[0] as? [String: AnyObject]
        } else {
            return nil
        }
    }
    
    internal func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}




