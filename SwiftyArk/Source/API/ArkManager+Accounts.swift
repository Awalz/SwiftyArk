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
     Request the balance of an Ark Account corresponding to the Ark address stored in `settings`.
     If settings is set to nil, this function will return `ApiError.settingsError`
     
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter balance: Optional account balance.
     */
    public func balance(completionHandler: @escaping(_ error: Error?, _ balance: Double?) -> ()) {
        
        guard let currentAddress = settings?.address else {
            completionHandler(ApiError.settingsError, nil)
            return
        }
        
        guard let url = URL(string: urlBase + ArkConstants.Routes.Accounts.getBalance(currentAddress)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        makeNetworkRequest(url: url) { (error, data) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            
            guard let json = self.jsonFrom(data) else {
                completionHandler(ApiError.unknownError, nil)
                return
            }
            
            if let balanceString = json["balance"] as? String {
                if let balance = Int(balanceString) {
                    completionHandler(nil, balance.arkIntConversion())
                } else {
                    completionHandler(ApiError.unknownError, nil)
                }
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    /**
     Request the balance of an Ark Account corresponding to the supplied Ark Address.
     
     - Parameter address: Ark address of requested account.
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter account: Optional `Account` object.
     */
    public func balance(address: String, completionHandler: @escaping(_ error: Error?, _ balance: Double?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.Accounts.getBalance(address)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        makeNetworkRequest(url: url) { (error, data) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            
            guard let json = self.jsonFrom(data) else {
                completionHandler(ApiError.unknownError, nil)
                return
            }
            
            if let balanceString = json["balance"] as? String {
                if let balance = Int(balanceString) {
                    completionHandler(nil, balance.arkIntConversion())
                } else {
                    completionHandler(ApiError.unknownError, nil)
                }
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    
    /**
     Request the public key of an Ark Account corresponding to the Ark address stored in `settings`.
     If settings is set to nil, this function will return `ApiError.settingsError`
     
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter publicKey: Optional public key.
     */
    public func publicKey(completionHandler: @escaping(_ error: Error?, _ publicKey: String?) -> ()) {
        
        guard let currentAddress = settings?.address else {
            completionHandler(ApiError.settingsError, nil)
            return
        }
        
        guard let url = URL(string: urlBase + ArkConstants.Routes.Accounts.getPublicKey(currentAddress)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        makeNetworkRequest(url: url) { (error, data) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            
            guard let json = self.jsonFrom(data) else {
                completionHandler(ApiError.unknownError, nil)
                return
            }
            
            if let publicKey = json["publicKey"] as? String {
                completionHandler(nil, publicKey)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    
    /**
     Request the public key of an Ark Account corresponding to the supplied Ark Address.
     
     - Parameter address: Ark address of requested account.
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter publicKey: Optional public key.
     */
    public func publicKey(address: String, completionHandler: @escaping(_ error: Error?, _ publicKey: String?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.Accounts.getPublicKey(address)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        makeNetworkRequest(url: url) { (error, data) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            
            guard let json = self.jsonFrom(data) else {
                completionHandler(ApiError.unknownError, nil)
                return
            }
            
            if let publicKey = json["publicKey"] as? String {
                completionHandler(nil, publicKey)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
