//
//  Voters.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

/// :nodoc:
public struct VotersResponse : Decodable {
    let success : Bool
    let voters  : [Voter]
    
    enum CodingKeys: String, CodingKey {
        case success
        case voters = "accounts"
    }
}

/// A Voter struct representing a vote for a `Delegate`
/// `Voter` is a condensced version of `Account`
public struct Voter : Decodable {
    
    // MARK: Properties

    /// Voter account username
    public let username  : String?
    
    /// Voter account address
    public let address   : String
    
    /// Voter account public key
    public let publicKey : String
    
    /// Voter account balance
    public let balance   : Double
    
    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        username  = try values.decode(String?.self,   forKey: .username)
        address   = try values.decode(String.self,   forKey: .address)
        publicKey = try values.decode(String.self,   forKey: .publicKey)
        
        guard let balanceInt = try Int(values.decode(String.self, forKey: .balance)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.balance], debugDescription: "Expecting Int representation of String"))
        }
        
        balance = balanceInt.arkIntConversion()
    }
    
    /// :nodoc:
    enum CodingKeys: String, CodingKey {
        case username, address, publicKey, balance
    }
}
