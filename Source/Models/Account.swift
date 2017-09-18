//
//  Account.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation


public struct AccountResponse : Decodable {
    let success : Bool
    let account : Account
}

public struct Account: Decodable {
    
    public let address                    : String
    public let unconfirmedBalance         : Int
    public let balance                    : Int
    public let publicKey                  : String
    public let unconfirmedSignature       : Int?
    public let secondSignature            : Int?
    public let multisignatures            : [String]?
    public let secondPublicKey            : String?
    public let unconfirmedMultisignatures : [String]?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decode(String.self, forKey: .address)
        
        guard let unconfirmedBalance = try Int(values.decode(String.self, forKey: .unconfirmedBalanceString)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.unconfirmedBalanceString], debugDescription: "Expecting Int representation of String"))
        }
        self.unconfirmedBalance = unconfirmedBalance
        
        guard let balance = try Int(values.decode(String.self, forKey: .balanceString)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.balanceString], debugDescription: "Expecting Int representation of String"))
        }
        self.balance = balance
        
        publicKey                  = try values.decode(String.self,   forKey: .publicKey)
        secondSignature            = try values.decode(Int.self,      forKey: .secondSignature)
        unconfirmedSignature       = try values.decode(Int.self,      forKey: .unconfirmedSignature)
        multisignatures            = try values.decode([String].self, forKey: .multisignatures)
        secondPublicKey            = try values.decode(String?.self,  forKey: .secondPublicKey)
        unconfirmedMultisignatures = try values.decode([String].self, forKey: .unconfirmedMultisignatures)
    }
    
    enum CodingKeys: String, CodingKey {
        case address, publicKey, secondPublicKey, unconfirmedSignature, multisignatures, secondSignature
        case balanceString              = "balance"
        case unconfirmedBalanceString   = "unconfirmedBalance"
        case unconfirmedMultisignatures = "u_multisignatures"
    }
}
