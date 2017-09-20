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
public struct Delegate : Decodable {
    
    // MARK: Properties
    
    /// Delegate username
    public let username       : String
    
    /// Delegate address
    public let address        : String
    
    /// Delegate address
    public let publicKey      : String
    
    /// Delegate votes
    public let votes          : Double
    
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
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        username        = try values.decode(String.self, forKey: .username)
        address         = try values.decode(String.self, forKey: .address)
        publicKey       = try values.decode(String.self, forKey: .publicKey)
        producedblocks  = try values.decode(Int.self,    forKey: .producedblocks)
        missedblocks    = try values.decode(Int.self,    forKey: .missedblocks)
        rate            = try values.decode(Int.self,    forKey: .rate)
        approval        = try values.decode(Float.self,  forKey: .approval)
        productivity    = try values.decode(Float.self,  forKey: .productivity)
        
        guard let votes = try Int(values.decode(String.self, forKey: .votes)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.votes], debugDescription: "Expecting Int representation of String"))
        }
        self.votes = votes.arkIntConversion()
    }
    
    /// :nodoc:
    enum CodingKeys: String, CodingKey {
        case username, address, publicKey, producedblocks, missedblocks, rate, approval, productivity
        case votes = "vote"
    }
}
