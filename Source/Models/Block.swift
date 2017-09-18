//
//  Block.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation


public struct BlockResponse : Decodable {
    let success : Bool
    let block   : Block
}
public struct BlocksResponse : Decodable {
    let success : Bool
    let blocks  : [Block]
}

public struct Block : Decodable {
    public let id                   : String
    public let version              : Int
    public let timestamp            : Date
    public let height               : Int
    public let previousBlock        : String
    public let numberOfTransactions : Int
    public let totalAmount          : Double
    public let totalFee             : Double
    public let reward               : Double
    public let payloadLength        : Int
    public let payloadHash          : String
    public let generatorPublicKey   : String
    public let generatorId          : String
    public let blockSignature       : String
    public let confirmations        : Int
    public let totalForged          : Double
    
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
    
    enum CodingKeys: String, CodingKey {
        case id, version, timestamp, height, previousBlock, numberOfTransactions, totalAmount, totalFee, reward, payloadLength, payloadHash, generatorPublicKey, generatorId, blockSignature, confirmations, totalForged
    }
}
