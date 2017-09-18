//
//  Transactions.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation


public struct TransactionsResponse : Decodable {
    let success      : Bool
    let transactions : [Transaction]
}

public struct TransactionResponse : Decodable {
    let success      : Bool
    let transaction  : Transaction
}

public struct Transaction : Decodable {
    public let id              : String
    public let blockid         : String
    public let type            : Int
    public let timestamp       : Date
    public let amount          : Double
    public let fee             : Double
    public let senderId        : String
    public let recipientId     : String
    public let senderPublicKey : String
    public let signature       : String
    public let confirmations   : Int
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id              = try values.decode(String.self, forKey: .id)
        blockid         = try values.decode(String.self, forKey: .blockid)
        type            = try values.decode(Int.self,    forKey: .type)
        amount          = try values.decode(Int.self,    forKey: .amount).arkIntConversion()
        fee             = try values.decode(Int.self,    forKey: .fee).arkIntConversion()
        senderId        = try values.decode(String.self, forKey: .senderId)
        recipientId     = try values.decode(String.self, forKey: .recipientId)
        senderPublicKey = try values.decode(String.self, forKey: .senderPublicKey)
        signature       = try values.decode(String.self, forKey: .signature)
        confirmations   = try values.decode(Int.self,    forKey: .confirmations)

        
        let timeStampInt = try values.decode(Int.self, forKey: .timestamp)
        timestamp = Date(timeStampInt)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, blockid, type, timestamp, amount, fee, senderId, recipientId, senderPublicKey, signature, confirmations
    }
}
