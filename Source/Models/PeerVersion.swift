//
//  PeerVersion.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

public struct PeerVersion: Decodable {
    public let version : String
    public let build   : String
}
