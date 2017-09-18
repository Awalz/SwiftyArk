//
//  Settings.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

public struct Settings {
    public let address   : String
    public let publicKey : String
    
    init(_ address: String, publicKey: String) {
        self.address   = address
        self.publicKey = publicKey
    }
    
    init(_ account: Account) {
        self.address   = account.address
        self.publicKey = account.publicKey
    }
    
    init(_ delegate: Delegate) {
        self.address   = delegate.address
        self.publicKey = delegate.publicKey
    }
}
