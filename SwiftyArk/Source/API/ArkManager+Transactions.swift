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

