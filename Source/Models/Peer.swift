//
//  Peer.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

public enum PeerStatus: String, Codable {
    case banned       = "EUNAVAILABLE"
    case disconnected = "ETIMEOUT"
    case connected    = "OK"
    case undefined    = "ERESPONSE"
}


public struct PeersResponse : Decodable {
    let success : Bool
    let peers   : [Peer]
}

public struct PeerResponse : Decodable {
    let success : Bool
    let peer    : Peer 
}

public struct Peer : Decodable {
    public let ip       : String
    public let port     : Int
    public let version  : String
    public let errors   : Int
    public let os       : String
    public let height   : Int
    public let status   : PeerStatus
    public let delay    : Int
}
