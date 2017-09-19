//
//  Transactions.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

/// :nodoc:
public struct TransactionsResponse : Decodable {
    let success      : Bool
    let transactions : [Transaction]
}


/// :nodoc:
public struct TransactionResponse : Decodable {
    let success      : Bool
    let transaction  : Transaction
}


/// Ark Transaction Struct
public struct Transaction : Decodable {
    
    // MARK: Properties
    
    /// Transaction Id
    public let id              : String
    
    /// Associated block Id
    public let blockid         : String
    
    /// Transaction type
    public let type            : Int
    
    /// Transaction timestamp
    public let timestamp       : Date
    
    /// Transaction amount
    public let amount          : Double
    
    /// Transaction fee
    public let fee             : Double
    
    /// Transaction sender Id
    public let senderId        : String
    
    /// Transaction recipient Id
    public let recipientId     : String
    
    /// Sender Public key
    public let senderPublicKey : String
    
    /// Transaction Signature
    public let signature       : String
    
    /// Number of confirmations
    public let confirmations   : Int
    
    /// Vender field
    public let vendorField     : String?
    
    /// :nodoc:
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
        
        if values.contains(.vendorField) == true {
            vendorField = try values.decode(String?.self, forKey: .vendorField)
        } else {
            vendorField = nil
        }
    
        let timeStampInt = try values.decode(Int.self, forKey: .timestamp)
        timestamp = Date(timeStampInt)
    }
    
    /// :nodoc:
    enum CodingKeys: String, CodingKey {
        case id, blockid, type, timestamp, amount, fee, senderId, recipientId, senderPublicKey, signature, confirmations, vendorField
    }
}