//
//  Status.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-18.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation


/// Ark Server Sync Status
public struct Status : Decodable {
    
    // MARK: Properties
    
    /// Server ID
    public let id      : String
    
    /// Stores whether server is syncing
    public let syncing : Bool
    
    /// Height
    public let height  : Int
}
