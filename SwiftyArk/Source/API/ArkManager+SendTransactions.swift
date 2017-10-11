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
    
    public func sendTransaction(_ recipientAddress: String, amount: Double, passphrase: String, secondPassphrase: String?, vendorField: String?, completionHandler: @escaping(_ error: Error?, _ response: NewTransactionResponse?) -> ()) {
        
        guard isConnectedToNetwork() == true else {
            completionHandler(ApiError.networkError, nil)
            return
        }
        
        createTransaction(recipientAddress, amount: amount, passphrase: passphrase, secondPassphrase: secondPassphrase, vendorField: vendorField) { (error, newTransaction) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            guard let transaction = newTransaction else {
                completionHandler(ApiError.unknownError, nil)
                return
            }
            
            guard let url = URL(string: "https://api.arknode.net/peer/transactions") else {
                completionHandler(ApiError.urlError, nil)
                return
            }
            
            let session = URLSession.shared
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue(ArkConstants.mainnetNethash,      forHTTPHeaderField: "nethash")
            request.setValue(String(ArkConstants.mainnetPort), forHTTPHeaderField: "port")
            request.setValue(ArkConstants.mainnetVersion,      forHTTPHeaderField: "version")
            
            var params = [String: AnyObject]()
            let transactions = [transaction.dictionary()]
            params.updateValue(transactions as AnyObject, forKey: "transactions")
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch let error {
                completionHandler(error, nil)
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request as URLRequest) { data, response, error in
                
                if let aError = error {
                    completionHandler(aError, nil)
                    return
                }
                
                guard let data = data else {
                    completionHandler(ApiError.unknownError, nil)
                    return
                }
                
                do {
                    let transactionResponse = try JSONDecoder().decode(NewTransactionResponse.self, from: data)
                    completionHandler(nil, transactionResponse)
                }
                catch let error {
                    completionHandler(error, nil)
                    return
                }
            }
            task.resume()
        }
    }
    
    public func sendVote(_ delegate: Delegate, passphrase: String, secondPassphrase: String?, completionHandler: @escaping(_ error: Error?, _ response: NewTransactionResponse?) -> ()) {
        
        guard isConnectedToNetwork() == true else {
            completionHandler(ApiError.networkError, nil)
            return
        }
        
        createVote(delegate, passphrase: passphrase, secondPassphrase: secondPassphrase, isUnvote: false) { (error, voteResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            
            guard let vote = voteResponse else {
                completionHandler(ApiError.unknownError, nil)
                return
            }
            
            guard let url = URL(string: "https://api.arknode.net/peer/transactions") else {
                completionHandler(ApiError.urlError, nil)
                return
            }
            
            let session = URLSession.shared
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue(ArkConstants.mainnetNethash,      forHTTPHeaderField: "nethash")
            request.setValue(String(ArkConstants.mainnetPort), forHTTPHeaderField: "port")
            request.setValue(ArkConstants.mainnetVersion,      forHTTPHeaderField: "version")
            
            var params = [String: AnyObject]()
            let voteDict = [vote.dictionary()]
            params.updateValue(voteDict as AnyObject, forKey: "transactions")
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch let error {
                completionHandler(error, nil)
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request as URLRequest) { data, response, error in
                
                if let aError = error {
                    completionHandler(aError, nil)
                    return
                }
                
                guard let data = data else {
                    completionHandler(ApiError.unknownError, nil)
                    return
                }
                
                do {
                    let transactionResponse = try JSONDecoder().decode(NewTransactionResponse.self, from: data)
                    completionHandler(nil, transactionResponse)
                }
                catch let error {
                    completionHandler(error, nil)
                    return
                }
            }
            task.resume()
            
        }
    }
    
    public func sendUnvote(_ delegate: Delegate, passphrase: String, secondPassphrase: String?, completionHandler: @escaping(_ error: Error?, _ response: NewTransactionResponse?) -> ()) {
        
        guard isConnectedToNetwork() == true else {
            completionHandler(ApiError.networkError, nil)
            return
        }
        
        createVote(delegate, passphrase: passphrase, secondPassphrase: secondPassphrase, isUnvote: true) { (error, voteResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            
            guard let vote = voteResponse else {
                completionHandler(ApiError.unknownError, nil)
                return
            }
            
            guard let url = URL(string: "https://api.arknode.net/peer/transactions") else {
                completionHandler(ApiError.urlError, nil)
                return
            }
            
            let session = URLSession.shared
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue(ArkConstants.mainnetNethash,      forHTTPHeaderField: "nethash")
            request.setValue(String(ArkConstants.mainnetPort), forHTTPHeaderField: "port")
            request.setValue(ArkConstants.mainnetVersion,      forHTTPHeaderField: "version")
            
            var params = [String: AnyObject]()
            let voteDict = [vote.dictionary()]
            params.updateValue(voteDict as AnyObject, forKey: "transactions")
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch let error {
                completionHandler(error, nil)
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request as URLRequest) { data, response, error in
                
                if let aError = error {
                    completionHandler(aError, nil)
                    return
                }
                
                guard let data = data else {
                    completionHandler(ApiError.unknownError, nil)
                    return
                }
                
                do {
                    let transactionResponse = try JSONDecoder().decode(NewTransactionResponse.self, from: data)
                    completionHandler(nil, transactionResponse)
                }
                catch let error {
                    completionHandler(error, nil)
                    return
                }
            }
            task.resume()
            
        }
    }
    
    /// :nodoc:
    private func createVote(_ delegate: Delegate, passphrase: String, secondPassphrase: String?, isUnvote: Bool, completionHandler: @escaping(_ error: Error?, _ newTransaction: NewTransaction?) -> ()) {
        
        var secondPassString: String!
        if let secondPass = secondPassphrase {
            secondPassString = "\"" + secondPass + "\""
        } else {
            secondPassString = "null"
        }
        
        var delegatePublicKeyString: String!
        if isUnvote == true {
            delegatePublicKeyString = "[\"-\(delegate.publicKey)\"]"
        } else {
            delegatePublicKeyString = "[\"+\(delegate.publicKey)\"]"
        }
        
        if let transactionFile = Bundle.main.path(forResource: "ark", ofType: "js") {
            do {
                let transactionLib = try String(contentsOfFile: transactionFile, encoding: String.Encoding.utf8)
                let context = JSContext()
                context!.evaluateScript(transactionLib)
                let script = "ark.vote.createVote(\"\(passphrase)\",\(delegatePublicKeyString!), \(secondPassString!));"
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
    
    /// :nodoc:
    private func createTransaction(_ recipientAddress: String, amount: Double, passphrase: String, secondPassphrase: String?, vendorField: String?, completionHandler: @escaping(_ error: Error?, _ newTransaction: NewTransaction?) -> ()) {
        
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
                print(script)
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
