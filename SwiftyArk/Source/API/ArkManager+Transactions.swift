//
//  ArkManager+Transactions.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-18.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

extension ArkManager {
    
    // MARK: Transactions
    
    
    /**
     Request an array of latest `Transaction`.
     
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter transactions: Optional array of `Transaction`.
     */
    public func transactions(completionHandler: @escaping(_ error: Error?, _ transactions: [Transaction]?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.getTransactions) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(TransactionsResponse.self, from: url) { (error, transactionsResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let transactions = transactionsResponse?.transactions {
                completionHandler(nil, transactions)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    
    /**
     Request a list of  `Transaction` corresponding to the Ark address stored in `settings`.
     List contains both sent and received transactions, sorted newest to oldest.
     If settings is set to nil, this function will return `ApiError.settingsError`
     
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter transactions: Optional list of `Transaction`.
     */
    public func myTransactions(completionHandler: @escaping(_ error: Error?, _ transactions: [Transaction]?) -> ()) {
        guard let currentAddress = settings?.address else {
            DispatchQueue.main.async {
                completionHandler(ApiError.settingsError, nil)
            }
            return
        }
        guard let senderURL = URL(string: urlBase + ArkConstants.Routes.getMySentTransactions(currentAddress)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        guard let recepientURL = URL(string: urlBase + ArkConstants.Routes.getMyReceivedTransactions(currentAddress)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(TransactionsResponse.self, from: senderURL) { (error, sentResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            
            if let sentTransactions = sentResponse?.transactions {
                self.fetch(TransactionsResponse.self, from: recepientURL) { (errror, receievedResponse) in
                    if let aError = error {
                        completionHandler(aError, nil)
                        return
                    }
                    
                    if let receivedTransactions = receievedResponse?.transactions {
                        let allTransactions : [Transaction] = sentTransactions + receivedTransactions
                        let sortedTransactions = allTransactions.sorted {$0.timestamp > $1.timestamp }
                        completionHandler(nil, sortedTransactions)
                    } else {
                        completionHandler(ApiError.unknownError, nil)
                    }
                }
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
        
    }
    
    /**
     Request a `Transaction` matching specified id.
     
     - Parameter id: `Transaction` id.
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter transaction: Optional `Transaction`.
     */
    public func transaction(id: String, completionHandler: @escaping(_ error: Error?, _ transaction: Transaction?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.getTransaction(id)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(TransactionResponse.self, from: url) { (error, transactionResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let transaction = transactionResponse?.transaction {
                completionHandler(nil, transaction)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
}

