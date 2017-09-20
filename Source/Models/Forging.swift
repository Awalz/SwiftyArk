//
//  Forging.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation


/// Ark Forging Data
public struct Forging : Decodable {
    
    // MARK: Properties
    
    /// Forging Fees
    public let fees    : Double
    
    /// Forging rewards
    public let rewards : Double
    
    /// Amount forged
    public let forged  : Double
    
    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let feeInt = try Int(values.decode(String.self, forKey: .fees)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.fees], debugDescription: "Expecting Int representation of String"))
        }
        
        fees = feeInt.arkIntConversion()
        
        guard let rewardInt = try Int(values.decode(String.self, forKey: .rewards)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.rewards], debugDescription: "Expecting Int representation of String"))
        }
        
        rewards = rewardInt.arkIntConversion()
        
        guard let forgedInt = try Int(values.decode(String.self, forKey: .forged)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.forged], debugDescription: "Expecting Int representation of String"))
        }
        
        forged = forgedInt.arkIntConversion()
    }
    
    /// :nodoc:
    enum CodingKeys: String, CodingKey {
        case fees, rewards, forged
    }
}
