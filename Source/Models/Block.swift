//
//  Block.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

/// :nodoc:
public struct BlockResponse : Decodable {
    let success : Bool
    let block   : Block
}

/// :nodoc:
public struct BlocksResponse : Decodable {
    let success : Bool
    let blocks  : [Block]
}

/// Ark Block
public struct Block : Decodable {
    
    // MARK: Properties
    
    /// Block Id
    public let id                   : String
    
    /// Block Version
    public let version              : Int
    
    /// Block Timestamp
    public let timestamp            : Date
    
    /// Block Height
    public let height               : Int
    
    /// Previous block
    public let previousBlock        : String
    
    /// Number of transactions
    public let numberOfTransactions : Int
    
    /// Total Amount
    public let totalAmount          : Double
    
    /// Total Fee
    public let totalFee             : Double
    
    /// Reward
    public let reward               : Double
    
    /// Payload Length
    public let payloadLength        : Int
    
    /// Payload Hash
    public let payloadHash          : String
    
    /// Generator Public Key
    public let generatorPublicKey   : String
    
    /// Generator ID
    public let generatorId          : String
    
    /// Block Signature
    public let blockSignature       : String
    
    /// Number of confirmations
    public let confirmations        : Int
    
    /// Total Forged
    public let totalForged          : Double
    
    
    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        version               = try values.decode(Int.self,    forKey: .version)
        height                = try values.decode(Int.self,    forKey: .height)
        numberOfTransactions  = try values.decode(Int.self,    forKey: .numberOfTransactions)
        payloadLength         = try values.decode(Int.self,    forKey: .payloadLength)
        confirmations         = try values.decode(Int.self,    forKey: .confirmations)
        id                    = try values.decode(String.self, forKey: .id)
        previousBlock         = try values.decode(String.self, forKey: .previousBlock)
        payloadHash           = try values.decode(String.self, forKey: .payloadHash)
        generatorPublicKey    = try values.decode(String.self, forKey: .generatorPublicKey)
        generatorId           = try values.decode(String.self, forKey: .generatorId)
        blockSignature        = try values.decode(String.self, forKey: .blockSignature)
        
        totalAmount           = try values.decode(Int.self,    forKey: .totalAmount).arkIntConversion()
        totalFee              = try values.decode(Int.self,    forKey: .totalFee).arkIntConversion()
        reward                = try values.decode(Int.self,    forKey: .reward).arkIntConversion()
        
        guard let totalForgedInt = try Int(values.decode(String.self, forKey: .totalForged)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.totalForged], debugDescription: "Expecting Int representation of String"))
        }
        
        totalForged = totalForgedInt.arkIntConversion()
        
        let timeStampInt = try values.decode(Int.self, forKey: .timestamp)
        timestamp = Date(timeStampInt)
    }
    
    /// :nodoc:
    enum CodingKeys: String, CodingKey {
        case id, version, timestamp, height, previousBlock, numberOfTransactions, totalAmount, totalFee, reward, payloadLength, payloadHash, generatorPublicKey, generatorId, blockSignature, confirmations, totalForged
    }
}
