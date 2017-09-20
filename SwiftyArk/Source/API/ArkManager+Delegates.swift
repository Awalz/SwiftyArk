//
//  ArkManager+Delegates.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-18.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

public extension ArkManager {
    
    // MARK: Delegates
    
    /**
     Request a `Delegate` corresponding to the supplied username.
     
     - Parameter username: Delegate username.
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter delegate: Optional `Delegate`.
     */
    public func delegate(_ username: String, completionHandler: @escaping(_ error: Error?, _ delegate: Delegate?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.getDelegate(username)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(DelegateResponse.self, from: url) { (error, delegateResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            
            if let delegate = delegateResponse?.delegate {
                completionHandler(nil, delegate)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    
    /**
     Request a list of top `Delegate`.
     List will be returned in descending order.

     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter delegates: Optional array of `Delegate`.
     */
    public func delegates(completionHandler: @escaping(_ error: Error?, _ delegates: [Delegate]?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.getDelegates) else {
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
     Request a list of top standby `Delegate`.
     List will be returned in descending order.
     
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter delegates: Optional array of `Delegate`.
     */
    public func standbyDelegates(completionHandler: @escaping(_ error: Error?, _ delegates: [Delegate]?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.getDelegates(51, offset: 51)) else {
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
     Request a list of `Delegate`.
     List will be returned in descending order.
     
     - Parameter limit: Requested list size.
     - Parameter offset: List starting point offset.
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter delegates: Optional array of `Delegate`.
     */
    public func delegates(limit: Int, offset: Int, completionHandler: @escaping(_ error: Error?, _ delegates: [Delegate]?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.getDelegates(limit, offset: offset)) else {
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
     Request an array of `Voter` corresponding to the public key stored in `settings`.
     If settings is set to nil, this function will return `ApiError.settingsError`
     
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter voters: Optional array of `Voter`.
     */
    public func voters(completionHandler: @escaping(_ error: Error?, _ voters: [Voter]?) -> ()) {
        guard let currentPublicKey = settings?.publicKey else {
            completionHandler(ApiError.settingsError, nil)
            return
        }
        
        guard let url = URL(string: urlBase + ArkConstants.Routes.getDelegateVotes(currentPublicKey)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(VotersResponse.self, from: url) { (error, votersResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let voters = votersResponse?.voters {
                completionHandler(nil, voters)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    
    /**
     Request an array of `Voter` corresponding to the supplied public key.
     
     - Parameter publicKey: Ark public key of Delegate.
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter voters: Optional array of `Voter`.
     */
    public func voters(publicKey: String, completionHandler: @escaping(_ error: Error?, _ voters: [Voter]?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.getDelegateVotes(publicKey)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(VotersResponse.self, from: url) { (error, votersResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let voters = votersResponse?.voters {
                completionHandler(nil, voters)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    
    /**
     Request the `Forging` data corresponding to the public key stored in `settings`.
     If settings is set to nil, this function will return `ApiError.settingsError`
     
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter forging: Optional `Forging` data.
     */
    public func forging(completionHandler: @escaping(_ error: Error?, _ forging: Forging?) -> ()) {
        guard let currentPublicKey = settings?.publicKey else {
            completionHandler(ApiError.settingsError, nil)
            return
        }
        
        guard let url = URL(string: urlBase + ArkConstants.Routes.getForging(currentPublicKey)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(Forging.self, from: url) { (error, forgingResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let forging = forgingResponse {
                completionHandler(nil, forging)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    
    /**
     Request the `Forging` data corresponding to provided public key.
     
     - Parameter publicKey: Ark public key of Delegate.
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter forging: Optional `Forging` data.
     */
    public func forging(publicKey: String, completionHandler: @escaping(_ error: Error?, _ forging: Forging?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.getForging(publicKey)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(Forging.self, from: url) { (error, forgingResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let forging = forgingResponse {
                completionHandler(nil, forging)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
}
