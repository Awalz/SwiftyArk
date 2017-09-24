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
public struct Account: Codable {
    
    // MARK: Properties
    
    /// Account Address
    public let address                    : String
    
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
    private let balanceString             : String
    
    /// :nodoc:
    private let unconfirmedBalanceString  : String
    
    /// Unconfirmed balance
    public var unconfirmedBalance : Double {
        if let balanceInt = Int(unconfirmedBalanceString) {
            return balanceInt.arkIntConversion()
        } else {
            return 0.0
        }
    }
    
    /// Current balance
    public var balance : Double {
        if let balanceInt = Int(balanceString) {
            return balanceInt.arkIntConversion()
        } else {
            return 0.0
        }
    }
    
    /// :nodoc:
    enum CodingKeys: String, CodingKey {
        case address, publicKey, secondPublicKey, unconfirmedSignature, multisignatures, secondSignature
        case balanceString              = "balance"
        case unconfirmedBalanceString   = "unconfirmedBalance"
        case unconfirmedMultisignatures = "u_multisignatures"
    }
}
