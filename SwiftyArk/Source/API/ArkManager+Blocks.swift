//
//  ArkManager+Blocks.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-18.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

public extension ArkManager {
    
    // MARK: Blocks

    /**
     Request a `Block` corresponding supplied block id.
     
     - Parameter blockID: Block id of requested block.
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter block: Optional `Block` object.
     */
    public func block(_ blockID: String, completionHandler: @escaping(_ error: Error?, _ block: Block?) -> ()) {
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
    
    /**
     Request an array of `Block` corresponding to the public key stored in `settings`.
     If settings is set to nil, this function will return `ApiError.settingsError`
     
     - Parameter limit: Requested limit of blocks.
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter blocks: Optional array of `Block`.
     */
    public func blocks(limit: Int, completionHandler: @escaping(_ error: Error?, _ blocks: [Block]?) -> ()) {
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
    
    /**
     Request an array of `Block` corresponding to the supplied public key.
     
     - Parameter publicKey: Public key for requested account.
     - Parameter limit: Requested limit of blocks.
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter blocks: Optional array of `Block`.
     */
    public func blocks(publicKey: Int, limit: Int, completionHandler: @escaping(_ error: Error?, _ blocks: [Block]?) -> ()) {
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
    
    /**
     Request the last `Block` object corresponding to the public key stored in `settings`.
     If settings is set to nil, this function will return `ApiError.settingsError`
     
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter block: Optional `Block`.
     */
    public func lastBlock(completionHandler: @escaping(_ error: Error?, _ block: Block?) -> ()) {
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
    
    
    /**
     Request the last `Block` object corresponding to the supplied public key.
     
     - Parameter publicKey: Public key for requested account.
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter block: Optional `Block`.
     */
    public func lastBlock(publicKey: Int, completionHandler: @escaping(_ error: Error?, _ block: Block?) -> ()) {
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
