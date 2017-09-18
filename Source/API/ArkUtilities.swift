//
//  ArkUtilities.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

extension Date {
     init(_ arkEpochTime: Int) {
        
        // Date of first forged Ark Block
        // 03/21/2017 @ 1:00pm (UTC)
        let arkEpochTimeIntervalSince1970 = TimeInterval(1490101200)
        
        let epochDate = Date(timeIntervalSince1970: arkEpochTimeIntervalSince1970)
        self.init(timeInterval: TimeInterval(arkEpochTime), since: epochDate)
    }
}

extension Int {
    func arkIntConversion() -> Double {
        return Double(self) * pow(10, -8)
    }
}
