//
//  Voters.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

public struct VotersResponse : Decodable {
    let success : Bool
    let voters  : [Voter]
    
    enum CodingKeys: String, CodingKey {
        case success
        case voters = "accounts"
    }
}

public struct Voter : Decodable {
    public let username  : String?
    public let address   : String
    public let publicKey : String
    public let balance   : Double
    
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
    
    enum CodingKeys: String, CodingKey {
        case username, address, publicKey, balance
    }
}
