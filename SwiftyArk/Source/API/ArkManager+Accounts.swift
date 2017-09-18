//
//  ArkManager+Accounts.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-18.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

public extension ArkManager {
    
    // MARK: Accounts
    
    /**
     Request an `Account` corresponding to the Ark address stored in `settings`.
     If settings is set to nil, this function will return `ApiError.settingsError`
     
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter account: Optional `Account` object.
     */
    public func account(completionHandler: @escaping(_ error: Error?, _ account: Account?) -> ()) {
        guard let currentAddress = settings?.address else {
            completionHandler(ApiError.settingsError, nil)
            return
        }
        
        guard let url = URL(string: urlBase + ArkConstants.Routes.getAccount(currentAddress)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(AccountResponse.self, from: url) { (error, accountResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let account = accountResponse?.account {
                completionHandler(nil, account)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    
    /**
     Request an `Account` corresponding to the supplied Ark Address
     
     - Parameter address: Ark address of requested account.
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter account: Optional `Account` object.
     */
    public func account(address: String, completionHandler: @escaping(_ error: Error?, _ account: Account?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.getAccount(address)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(AccountResponse.self, from: url) { (error, accountResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let account = accountResponse?.account {
                completionHandler(nil, account)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    
    
    /**
     Request the `Delegate` votes corresponding to the Ark address stored in `settings`
     If settings is set to nil, this function will return `ApiError.settingsError`
     
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter votes: Optional array of `Delegate` .
     */
    public func votes(completionHandler: @escaping(_ error: Error?, _ votes: [Delegate]?) -> ()) {
        guard let currentAddress = settings?.address else {
            completionHandler(ApiError.settingsError, nil)
            return
        }
        
        guard let url = URL(string: urlBase + ArkConstants.Routes.getVotes(currentAddress)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(DelegatesResponse.self, from: url) { (error, delegatesResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let delegates = delegatesResponse?.delegates {
                let sortedDelegates = delegates.sorted {$0.rate < $1.rate}
                completionHandler(nil, sortedDelegates)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    
    /**
     Request the `Delegate` votes corresponding to supplied Ark address.
     
     - Parameter address: Ark address of requested account.
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter votes: Optional array of `Delegate`.
     */
    public func votes(arkAddress: String, completionHandler: @escaping(_ error: Error?, _ votes: [Delegate]?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.getVotes(arkAddress)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(DelegatesResponse.self, from: url) { (error, delegatesResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let delegates = delegatesResponse?.delegates {
                let sortedDelegates = delegates.sorted {$0.rate < $1.rate}
                completionHandler(nil, sortedDelegates)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
}
