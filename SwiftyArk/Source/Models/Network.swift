//
//  Network.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-16.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation


/// Network presets for configuring `ArkManager` session
public enum NetworkPreset: String {
    /// https://node1.arknet.cloud/api/
    case arknet1 = "https://node1.arknet.cloud/api/"
    
    /// https://node2.arknet.cloud/api/
    case arknet2 = "https://node2.arknet.cloud/api/"
}

/// Network struct to store custom server settings
public struct Network {
    
    // MARK: Properties
    
    /// Server IP address
    public let ip    : String
    
    /// Server port
    public let port  : Int
    
    /// Server SSL settings
    public let isSSL : Bool
    
    /// Computed base url string
    public var urlBase: String {
        if isSSL == true {
            let firstHalf  = "https://" + ip + ":"
            let secondHalf = String(port) + "/api/"
            return firstHalf + secondHalf
        } else {
            let firstHalf  = "http://" + ip + ":"
            let secondHalf = String(port) + "/api/"
            return firstHalf + secondHalf
        }
    }
    
    // MARK: Initializers

    /**
     Public `Network` initializer
     
     - Parameter ip: Server IP address.
     - Parameter port: Server port
     - Parameter isSSL: OServer SSL settings.
     */
    public init(_ ip: String, port: Int, isSSL: Bool) {
        self.ip    = ip
        self.port  = port
        self.isSSL = isSSL
    }
}
