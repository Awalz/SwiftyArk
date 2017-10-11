//
//  ArkManager+Peers.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-18.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

extension ArkManager {
    
    // MARK: Peers

    /**
     Request a list of `Peer` on current server.
     
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter peers: Optional array of `Peer`.
     */
    public func peers(completionHandler: @escaping(_ error: Error?, _ peers: [Peer]?) -> ()) {
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
    
    
    /**
     Request a `Peer` matching specified server information.
     
     - Parameter ip: IP address of peer.
     - Parameter port: Port of peer.
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter peer: Optional `Peer` matching server information.
     */
    public func peer(ip: String, port: Int, completionHandler: @escaping(_ error: Error?, _ peer: Peer?) -> ()) {
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
    
    /**
     Request a `Peerversion` information from current session.
     
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional error.
     - Parameter peerVersion: Optional `PeerVersion`.
     */
    public func peerVersion(completionHandler: @escaping(_ error: Error?, _ peerVersion: PeerVersion?) -> ()) {
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
