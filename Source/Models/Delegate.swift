//
//  Delegate.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-16.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

public struct DelegateResponse : Decodable {
    let success  : Bool
    let delegate : Delegate
}

public struct DelegatesResponse : Decodable {
    let success   : Bool
    let delegates : [Delegate]
}

public struct Delegate : Decodable {
    public let username       : String
    public let address        : String
    public let publicKey      : String
    public let vote           : String
    public let producedblocks : Int
    public let missedblocks   : Int
    public let rate           : Int
    public let approval       : Float
    public let productivity   : Float
}
