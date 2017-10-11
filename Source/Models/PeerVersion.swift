//
//  PeerVersion.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation


/// Peer Version Struct
public struct PeerVersion: Decodable {
    
    // MARK: Properties
    
    /// Peer version
    public let version : String
    
    /// Peer build
    public let build   : String
}
