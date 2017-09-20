//
//  ArkManager.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-16.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

/// API Errors.
public enum ApiError: Error {
    /// Session settings (ark account and public key) not set.
    case settingsError
    
    /// Unable to connect to the network.
    case networkError
    
    /// Could not create valid URL.
    case urlError
    
    /// Unable to read response data or unknown issue.
    case unknownError
    
    /// Parameters passed to newtorking call were invalid.
    case parameterError
}

/**
 ArkManager is a manager class for accessing the Ark API.
 
 Instances allows you to make requests to access accounts, delegate, block, peer, transaction and tickers all with a convenienet api. The manager can be configured with `Settings` to allow easy accessing of `Delegate` and `Account` information.
 
 ArkManager also allows for easy switching of server settings with `NetworkPreset` or custom `Network` object.
 
 */
public class ArkManager : NSObject {
    
    // MARK: Properties

    /**
     The base URL used for all network calls.
     
     Default is [NetworkPreset.arknet1](https://node1.arknet.cloud/api/)
     
     Cannot be modified directly. Updating is done with `updateNetworkPreset(_:)` or `updateNetwork(_:)'
     
     */
    public private(set) var urlBase : String = NetworkPreset.arknet1.rawValue
    
    /**
     The session settings for easy `Account` and `Delegate` fetching.
     
     Stores the `ark address` and `public key` for easy use.
     
     Cannot be modified directly. Updating is done with `updateSettings(account:)`, `updateSettings(delegate:)` or `updateSettings(settings:)`
     
     */
    public private(set) var settings : Settings?
    
    // MARK: Settings

    /**
     Update settings of current session with `Account`.
     
     - Parameter account: `Account` object.
     */
    public func updateSettings(account: Account) {
        settings = Settings(account)
    }
    
    /**
     Update settings of current session with `Delegate`.
     
     - Parameter delegate: `Delegate` object.
     */
    public func updateSettings(delegate: Delegate) {
        settings = Settings(delegate)
    }
    
    /**
     Update settings of current session with `Settings`.
     
     - Parameter settings: `Settings` object.
     */
    public func updateSettings(settings: Settings) {
        self.settings = settings
    }
    
    // MARK: Network

    /**
     Update network settings with `NetworkPreset`.
     
     - Parameter preset: `NetworkPreset` object.
     */
    public func updateNetworkPreset(_ preset: NetworkPreset) {
        urlBase = preset.rawValue
    }
    
    /**
     Update network settings with custom `Network`.
     
     - Parameter network: `Network` object.
     */
    public func updateNetwork(_ network: Network) {
        urlBase = network.urlBase
    }
}


