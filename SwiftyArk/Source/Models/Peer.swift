//
//  Peer.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

/// Current Status of peer.
public enum PeerStatus: String, Codable {
    /// Banned.
    case banned       = "EUNAVAILABLE"
    /// Disconnected or server timeout
    case disconnected = "ETIMEOUT"
    
    /// Connected
    case connected    = "OK"
    
    /// Unknown response
    case undefined    = "ERESPONSE"
}

/// :nodoc:
public struct PeersResponse : Decodable {
    let success : Bool
    let peers   : [Peer]
}


/// :nodoc:
public struct PeerResponse : Decodable {
    let success : Bool
    let peer    : Peer 
}


/// Ark Network Peer
public struct Peer : Decodable {
    
    // MARK: Properties
    
    /// Peer IP address
    public let ip       : String
    
    /// Peer port
    public let port     : Int
    
    /// Peer version
    public let version  : String
    
    /// Error count
    public let errors   : Int
    
    /// Peer operating system
    public let os       : String
    
    /// Height
    public let height   : Int
    
    /// Peer status
    public let status   : PeerStatus
    
    /// Peer delay
    public let delay    : Int
}
