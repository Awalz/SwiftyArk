//
//  ArkDataManager.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-16.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

public extension ArkManager {
    
    public enum ApiError: Error {
        case settingsError
        case networkError
        case urlError
        case unknownError
    }
    
    fileprivate func makeNetworkRequest(url: URL, completionHandler: @escaping(_ error: Error?, _ data: Data?) -> ()) {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(10)
        configuration.timeoutIntervalForResource = TimeInterval(10)
        let session = URLSession(configuration: configuration)
        
        session.dataTask(with: url) { (data, response, error) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            completionHandler(nil, data)
            }.resume()
    }
    
    fileprivate func fetch<T : Decodable>(_ type: T.Type, from url: URL, completionHandler: @escaping(_ error: Error?, _ data: T?) -> ()) {
        makeNetworkRequest(url: url) { (error, data) in
            if let aError = error {
                completionHandler(aError, nil)
            } else if let aData = data {
                do {
                    let myStruct = try JSONDecoder().decode(T.self, from: aData)
                    completionHandler(nil, myStruct)
                }
                catch let error {
                    completionHandler(error, nil)
                    return
                }
            }
        }
    }
}

// MARK: Account
public extension ArkManager {
    
    public func account(completionHandler: @escaping(_ error: Error?, _ data: Account?) -> ()) {
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
    
    public func votes(completionHandler: @escaping(_ error: Error?, _ data: [Delegate]?) -> ()) {
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
    
    public func votes(arkAddress: String, completionHandler: @escaping(_ error: Error?, _ data: [Delegate]?) -> ()) {
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

// MARK: Block
public extension ArkManager {
    
    public func block(_ blockID: String, completionHandler: @escaping(_ error: Error?, _ data: Block?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.getBlock(blockID)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(BlockResponse.self, from: url) { (error, blockResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let block = blockResponse?.block {
                completionHandler(nil, block)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    
    public func blocks(limit: Int, completionHandler: @escaping(_ error: Error?, _ data: [Block]?) -> ()) {
        guard let currentPublicKey = settings?.publicKey else {
            completionHandler(ApiError.settingsError, nil)
            return
        }
        
        guard let url = URL(string: urlBase + ArkConstants.Routes.getBlocks(currentPublicKey, limit: limit)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(BlocksResponse.self, from: url) { (error, blocksResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let blocks = blocksResponse?.blocks {
                completionHandler(nil, blocks)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    
    public func lastBlock(completionHandler: @escaping(_ error: Error?, _ data: Block?) -> ()) {
        guard let currentPublicKey = settings?.publicKey else {
            completionHandler(ApiError.settingsError, nil)
            return
        }
        
        guard let url = URL(string: urlBase + ArkConstants.Routes.getBlocks(currentPublicKey, limit: 1)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(BlocksResponse.self, from: url) { (error, blocksResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let block = blocksResponse?.blocks.first {
                completionHandler(nil, block)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
}

// MARK: Delegate
public extension ArkManager {
    
    public func delegate(_ username: String, completionHandler: @escaping(_ error: Error?, _ data: Delegate?) -> ()) {
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
    
    public func delegates(completionHandler: @escaping(_ error: Error?, _ data: [Delegate]?) -> ()) {
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
    
    public func standbyDelegates(completionHandler: @escaping(_ error: Error?, _ data: [Delegate]?) -> ()) {
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
    
    public func delegates(limit: Int, offset: Int, completionHandler: @escaping(_ error: Error?, _ data: [Delegate]?) -> ()) {
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
    
    public func voters(completionHandler: @escaping(_ error: Error?, _ data: [Voter]?) -> ()) {
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
    
    public func voters(publicKey: String, completionHandler: @escaping(_ error: Error?, _ data: [Voter]?) -> ()) {
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
    
    public func forging(completionHandler: @escaping(_ error: Error?, _ data: Forging?) -> ()) {
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
    
    public func forging(publicKey: String, completionHandler: @escaping(_ error: Error?, _ data: Forging?) -> ()) {
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

// MARK: Peer
extension ArkManager {
    
    public func peers(completionHandler: @escaping(_ error: Error?, _ data: [Peer]?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.getPeers) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(PeersResponse.self, from: url) { (error, peersResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let peers = peersResponse?.peers {
                completionHandler(nil, peers)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    
    public func peer(ip: String, port: Int, completionHandler: @escaping(_ error: Error?, _ data: Peer?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.getPeer(ip, port: port)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(PeerResponse.self, from: url) { (error, peerResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let peer = peerResponse?.peer {
                completionHandler(nil, peer)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
    
    public func peerVersion(completionHandler: @escaping(_ error: Error?, _ data: PeerVersion?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.peerVersion) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(PeerVersion.self, from: url) { (error, peerVersionResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let peerVersion = peerVersionResponse {
                completionHandler(nil, peerVersion)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
}

// Mark: Status
extension ArkManager {
    
    public func syncStatus(completionHandler: @escaping(_ error: Error?, _ data: Status?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.syncStatus) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(Status.self, from: url) { (error, statusResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let status = statusResponse {
                completionHandler(nil, status)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
}



// MARK: Ticker
extension ArkManager {
    
    public func arkTicker(currency: TickerCurrency, completionHandler: @escaping(_ error: Error?, _ data: ArkTicker?) -> ()) {
        guard let url = URL(string: ArkConstants.Routes.arkTicker(currency)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
                
        makeNetworkRequest(url: url) { (error, data) in
            if let aError = error {
                completionHandler(aError, nil)
            } else if let aData = data {
                if let ticker = ArkTicker(currency: currency, data: aData) {
                    completionHandler(nil, ticker)
                } else {
                    completionHandler(ApiError.unknownError, nil)
                }
            }
        }
    }
}

// MARK: Transactions
extension ArkManager {
    
    public func transactions(completionHandler: @escaping(_ error: Error?, _ data: [Transaction]?) -> ()) {
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
    
    public func transaction(id: String, completionHandler: @escaping(_ error: Error?, _ data: Transaction?) -> ()) {
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



