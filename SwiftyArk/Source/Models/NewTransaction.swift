//
//  NewTransaction.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-27.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation


public struct NewTransaction {
    
    public let recipientId : String
    public let timestamp       : Int
    public let signature       : String
    public let id              : String
    public let type            : Int
    public let senderPublicKey : String
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
              let fee             : Int                 = dictionary["fee"]             as? Int
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
        
        if let vendorField : String = dictionary["vendorField"] as? String {
            self.vendorField = vendorField
        } else {
            self.vendorField = nil
        }
    }
}
