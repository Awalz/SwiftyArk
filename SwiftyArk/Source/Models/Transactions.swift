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
public struct Transaction : Codable, Comparable {
    
    /// :nodoc:
    static public func ==(lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.id == rhs.id
    }
    
    /// :nodoc:
    static public func <(lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.timestamp < rhs.timestamp
    }
    
    // MARK: Properties
    
    /// Transaction Id
    public let id              : String
    
    /// Associated block Id
    public let blockid         : String
    
    /// Transaction type
    public let type            : Int
    
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
    private let timeStampInt : Int
    
    /// :nodoc:
    private let amountInt : Int
    
    /// :nodoc:
    private let feeInt : Int
    
    /// Transaction timestamp
    public var timestamp : Date {
        return Date(timeStampInt)
    }
    
    /// Transaction amount
    public var amount : Double {
        return amountInt.arkIntConversion()
    }
    
    /// Transaction fee
    public var fee : Double {
        return feeInt.arkIntConversion()
    }
    
    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id              = try values.decode(String.self, forKey: .id)
        blockid         = try values.decode(String.self, forKey: .blockid)
        type            = try values.decode(Int.self,    forKey: .type)
        amountInt       = try values.decode(Int.self,    forKey: .amountInt)
        feeInt          = try values.decode(Int.self,    forKey: .feeInt)
        senderId        = try values.decode(String.self, forKey: .senderId)
        recipientId     = try values.decode(String.self, forKey: .recipientId)
        senderPublicKey = try values.decode(String.self, forKey: .senderPublicKey)
        signature       = try values.decode(String.self, forKey: .signature)
        confirmations   = try values.decode(Int.self,    forKey: .confirmations)
        timeStampInt    = try values.decode(Int.self,    forKey: .timeStampInt)
        
        if values.contains(.vendorField) == true {
            vendorField = try values.decode(String?.self, forKey: .vendorField)
        } else {
            vendorField = nil
        }
    }
    
    /// :nodoc:
    enum CodingKeys: String, CodingKey {
        case id, blockid, type, senderId, recipientId, senderPublicKey, signature, confirmations, vendorField
        case timeStampInt = "timestamp"
        case amountInt = "amount"
        case feeInt    = "fee"
    }
}
