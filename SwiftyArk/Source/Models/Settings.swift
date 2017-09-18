//
//  Settings.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

/// ArkManager Session Settings
public struct Settings {
    
    // MARK: Properties
    
    /// Session address
    public let address   : String
    
    /// Session public key
    public let publicKey : String
    
    // MARK: Initializers
    
    /**
     Public `Settings` initializer
     
     - Parameter address: Session address.
     - Parameter publicKey: Session public key
     */
    public init(_ address: String, publicKey: String) {
        self.address   = address
        self.publicKey = publicKey
    }
    
    /**
     Public `Settings` initializer
     
     - Parameter account: Ark account to use for session.
     */
    public init(_ account: Account) {
        self.address   = account.address
        self.publicKey = account.publicKey
    }
    
    
    /**
     Public `Settings` initializer
     
     - Parameter delegate: Ark Delegate to use for session.
     */
    public init(_ delegate: Delegate) {
        self.address   = delegate.address
        self.publicKey = delegate.publicKey
    }
}
