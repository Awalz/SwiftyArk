//
//  Delegate.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-16.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

/// :nodoc:
public struct DelegateResponse : Decodable {
    let success  : Bool
    let delegate : Delegate
}


/// :nodoc:
public struct DelegatesResponse : Decodable {
    let success   : Bool
    let delegates : [Delegate]
}

/// Ark Delegate
public struct Delegate : Codable {
    
    // MARK: Properties
    
    /// Delegate username
    public let username       : String
    
    /// Delegate address
    public let address        : String
    
    /// Delegate address
    public let publicKey      : String
    
    /// Produced blocks
    public let producedblocks : Int
    
    /// Missed blocks
    public let missedblocks   : Int
    
    /// Delegate rate
    public let rate           : Int
    
    /// Delegate approval
    public let approval       : Float
    
    /// Delegate productivity
    public let productivity   : Float
    
    /// :nodoc:
    private let voteString    : String

    /// Delegate votes
    public var votes : Double {
        guard let voteInt = Int(voteString) else {
            return 0.0
        }
        return voteInt.arkIntConversion()
    }
    
    /// Boolean to indicator if Delegate is in top 51 and forging.
    public var isForging : Bool {
        return rate <= 51
    }
    
    /// :nodoc:
    enum CodingKeys: String, CodingKey {
        case username, address, publicKey, producedblocks, missedblocks, rate, approval, productivity
        case voteString = "vote"
    }
}
