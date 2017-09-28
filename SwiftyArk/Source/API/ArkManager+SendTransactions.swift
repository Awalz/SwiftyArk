//
//  ArkManager+SendTransactions.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-27.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation
import JavaScriptCore

extension ArkManager {
    
    public func createTransaction(_ recipientAddress: String, amount: Double, passphrase: String, secondPassphrase: String?, vendorField: String?, completionHandler: @escaping(_ error: Error?, _ newTransaction: NewTransaction?) -> ()) {
        
        var vendorFieldString: String!
        if let vField = vendorField {
            vendorFieldString = "\"" + vField + "\""
        } else {
            vendorFieldString = "null"
        }
        
        var secondPassString: String!
        if let secondPass = secondPassphrase {
            secondPassString = "\"" + secondPass + "\""
        } else {
            secondPassString = "null"
        }
        
        if let transactionFile = Bundle.main.path(forResource: "ark", ofType: "js") {
            do {
                let transactionLib = try String(contentsOfFile: transactionFile, encoding: String.Encoding.utf8)
                let context = JSContext()
                context!.evaluateScript(transactionLib)
                let script = "ark.transaction.createTransaction(\"\(recipientAddress)\", \(amount.arkToInt()), \(vendorFieldString!), \"\(passphrase)\", \(secondPassString!));"
                let result = context!.evaluateScript(script)
                if let object = result {
                    if let transaction = NewTransaction(dictionary: object.toDictionary()) {
                        completionHandler(nil, transaction)
                    } else {
                        completionHandler(ApiError.unknownError, nil)
                    }
                } else {
                    completionHandler(ApiError.unknownError, nil)
                }
            } catch (let error) {
                completionHandler(error, nil)
            }
        } else {
            completionHandler(ApiError.unknownError, nil)
        }
    }
}
