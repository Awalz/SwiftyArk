//
//  Status.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-18.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

public struct Status : Decodable {
    
    public let id      : String
    public let syncing : Bool
    public let height  : Int
}
