//
//  NewTransaction.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-27.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

/// :nodoc:
public struct NewTransactionResponse : Decodable {
    public let success         : Bool
    public let errorMessage    : String?
    public let transactionIds  : [String]?
    
    enum CodingKeys: String, CodingKey {
        case success, transactionIds
        case errorMessage = "error"
    }
}

/// :nodoc:
public struct NewTransaction {
    
    public let recipientId     : String
    public let timestamp       : Int
    public let signature       : String
    public let id              : String
    public let type            : Int
    public let senderPublicKey : String
    public let amount          : Int
    public let fee             : Int
    public let asset           : [String : AnyObject]
    public let vendorField     : String?
    
    public init?(dictionary:  [AnyHashable : Any]) {
        guard let recipientId     : String              = dictionary["recipientId"]     as? String,
              let timeStamp       : Int                 = dictionary["timestamp"]       as? Int,
              let signature       : String              = dictionary["signature"]       as? String,
              let id              : String              = dictionary["id"]              as? String,
              let type            : Int                 = dictionary["type"]            as? Int,
              let senderPublicKey : String              = dictionary["senderPublicKey"] as? String,
              let asset           : [String: AnyObject] = dictionary["asset"]           as? [String: AnyObject],
              let fee             : Int                 = dictionary["fee"]             as? Int,
              let amount          : Int                 = dictionary["amount"]             as? Int

        else {
            return nil
        }
        self.recipientId     = recipientId
        self.timestamp       = timeStamp
        self.id              = id
        self.signature       = signature
        self.type            = type
        self.senderPublicKey = senderPublicKey
        self.fee             = fee
        self.asset           = asset
        self.amount          = amount
        
        if let vendorField : String = dictionary["vendorField"] as? String {
            self.vendorField = vendorField
        } else {
            self.vendorField = nil
        }
    }
    
    public func dictionary() -> [String: AnyObject] {
        var dict = [String: AnyObject]()
        dict.updateValue(recipientId as AnyObject, forKey: "recipientId")
        dict.updateValue(asset as AnyObject, forKey: "asset")
        dict.updateValue(id as AnyObject, forKey: "senderID")
        dict.updateValue(type as AnyObject, forKey: "type")
        dict.updateValue(amount as AnyObject, forKey: "amount")
        dict.updateValue(senderPublicKey as AnyObject, forKey: "senderPublicKey")
        dict.updateValue(fee as AnyObject, forKey: "fee")
        dict.updateValue(timestamp as AnyObject, forKey: "timestamp")
        dict.updateValue(signature as AnyObject, forKey: "signature")
        
        if let vendorString = vendorField {
            dict.updateValue(vendorString as AnyObject, forKey: "vendorField")
        }
        return dict
    }
}
