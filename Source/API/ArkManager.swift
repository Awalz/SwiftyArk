//
//  ArkManager.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-16.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

public class ArkManager : NSObject {
    
    public private(set) var urlBase : String = NetworkPreset.arknet1.rawValue
    
    public private(set) var settings : Settings?
    
    public func updateSettings(_ account: Account) {
        settings = Settings(account)
    }
    
    public func updateSettings(_ delegate: Delegate) {
        settings = Settings(delegate)
    }
    
    public func updateSettings(_ settings: Settings) {
        self.settings = settings
    }
    
    public func updateNetworkPreset(_ networkPreset: NetworkPreset) {
        urlBase = networkPreset.rawValue
    }
    
    public func updateNetwork(_ network: Network) {
        urlBase = network.urlBase
    }
}


