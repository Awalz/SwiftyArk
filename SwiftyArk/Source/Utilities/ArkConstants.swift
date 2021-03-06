//
//  ArkConstants.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-16.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

/// :nodoc:
struct ArkConstants {
    
    static let mainnetNethash = "6e84d08bd299ed97c212c886c98a57e36545c8f5d645ca7eeae63a8bd62d8988"
    
    static let mainnetVersion = "1.0.1"
    
    static let mainnetPort = 4001
    
    
    struct Routes {
        
        struct Accounts {
            static func getBalance(_ address: String) -> String {
                return "accounts/getBalance?address=\(address)"
            }
            
            static func getPublicKey(_ address: String) -> String {
                return "accounts/getPublickey?address=\(address)"
            }
            
            static func getVotes(_ address: String) -> String {
                return "accounts/delegates?address=\(address)"
            }
            
            static func getAccount(_ address: String) -> String {
                return "accounts?address=\(address)"
            }
            
            static let voteForDelegate =  "accounts/delegates"
        }

        static func getBlocks(_ publicKey: String, limit: Int) -> String {
            return "blocks?generatorPublicKey=\(publicKey)&limit=\(limit)&offset=0&orderBy=height:desc"
        }
        
        static func getBlock(_ blockId: String) -> String {
            return "blocks/get?id=\(blockId)"
        }
        
        static func getDelegate(_ username: String) -> String {
            return "delegates/get?username=\(username)"
        }
        
        static let getDelegates = "delegates"
        
        static func getDelegates(_ limit: Int, offset: Int) -> String {
            return "delegates?limit=\(limit)&offset=\(offset)&orderBy=rate:asc"
        }
        
        static func getDelegateVotes(_ publicKey: String) -> String {
            return "delegates/voters?publicKey=\(publicKey)"
        }
        
        static func getForging(_ publicKey: String) -> String {
            return "delegates/forging/getForgedByAccount?generatorPublicKey=\(publicKey)"
        }
        
        static let getPeers = "peers"
        
        static func getPeer(_ ip: String, port: Int) -> String {
            return "peers/get?ip=\(ip)&port=\(port)"
        }
        
        static let syncStatus =  "loader/status/sync"
        
        static let peerVersion = "peers/version"
        
        static let getTransactions = "transactions"
        
        static let getNethash = "blocks/getNethash"
        
        static let sendTransaction = "peer/transactions"
        
        static func getTransaction(_ transactionId: String) -> String {
            return "transactions/get?id=\(transactionId)"
        }
        
        static func getMyReceivedTransactions(_ address: String) -> String {
            return "transactions?recipientId=\(address)"
        }
        
        static func getMySentTransactions(_ address: String) -> String {
            return "transactions?senderId=\(address)"
            
        }
        
        static func arkTicker(_ currency: Currency) -> String {
            return "https://api.coinmarketcap.com/v1/ticker/ark/?convert=\(currency.rawValue)"
        }
    }
}




