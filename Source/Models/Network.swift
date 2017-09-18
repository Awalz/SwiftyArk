//
//  Network.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-16.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

public enum NetworkPreset: String {
    case arknet1 = "https://node1.arknet.cloud/api/"
    case arknet2 = "https://node2.arknet.cloud/api/"
}

public struct Network {
    public let ip    : String
    public let port  : Int
    public let isSSL : Bool
    
    init(_ ip: String, port: Int, isSSL: Bool) {
        self.ip    = ip
        self.port  = port
        self.isSSL = isSSL
    }
    
    var urlBase: String {
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
}
