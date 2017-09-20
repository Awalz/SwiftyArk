//
//  Account.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

/// :nodoc:
public struct AccountResponse : Decodable {
    let success : Bool
    let account : Account
}


/// Ark Account
public struct Account: Decodable {
    
    // MARK: Properties
    
    /// Account Address
    public let address                    : String
    
    /// Unconfirmed balance
    public let unconfirmedBalance         : Double
    
    /// Current balance
    public let balance                    : Double
    
    /// Public key
    public let publicKey                  : String
    
    /// Unconfirmed signature
    public let unconfirmedSignature       : Int?
    
    /// Second Signature
    public let secondSignature            : Int?
    
    /// Multisignatures
    public let multisignatures            : [String]?
    
    /// Second public key
    public let secondPublicKey            : String?
    
    /// Unconfirmed Multisgnatures
    public let unconfirmedMultisignatures : [String]?
    
    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decode(String.self, forKey: .address)
        
        guard let unconfirmedBalance = try Int(values.decode(String.self, forKey: .unconfirmedBalanceString)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.unconfirmedBalanceString], debugDescription: "Expecting Int representation of String"))
        }
        self.unconfirmedBalance = unconfirmedBalance.arkIntConversion()
        
        guard let balance = try Int(values.decode(String.self, forKey: .balanceString)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.balanceString], debugDescription: "Expecting Int representation of String"))
        }
        self.balance = balance.arkIntConversion()
        
        publicKey                  = try values.decode(String.self,   forKey: .publicKey)
        secondSignature            = try values.decode(Int.self,      forKey: .secondSignature)
        unconfirmedSignature       = try values.decode(Int.self,      forKey: .unconfirmedSignature)
        multisignatures            = try values.decode([String].self, forKey: .multisignatures)
        secondPublicKey            = try values.decode(String?.self,  forKey: .secondPublicKey)
        unconfirmedMultisignatures = try values.decode([String].self, forKey: .unconfirmedMultisignatures)
    }
    
    /// :nodoc:
    enum CodingKeys: String, CodingKey {
        case address, publicKey, secondPublicKey, unconfirmedSignature, multisignatures, secondSignature
        case balanceString              = "balance"
        case unconfirmedBalanceString   = "unconfirmedBalance"
        case unconfirmedMultisignatures = "u_multisignatures"
    }
}
