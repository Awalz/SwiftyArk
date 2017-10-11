//
//  ArkUtilities.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

/// :nodoc:
extension Date {
     init(_ arkEpochTime: Int) {
        
        // Date of first forged Ark Block
        // 03/21/2017 @ 1:00pm (UTC)
        let arkEpochTimeIntervalSince1970 = TimeInterval(1490101200)
        
        let epochDate = Date(timeIntervalSince1970: arkEpochTimeIntervalSince1970)
        self.init(timeInterval: TimeInterval(arkEpochTime), since: epochDate)
    }
}

/// :nodoc:
extension Int {
    func arkIntConversion() -> Double {
        return Double(self) * pow(10, -8)
    }
}

/// :nodoc:
extension Double {
    func arkToInt() -> Int {
        return Int(self * pow(10, 8))
    }
}

/// :nodoc:
extension Array where Element: Equatable {
    /// Array containing only _unique_ elements.
    var unique: [Element] {
        var result: [Element] = []
        for element in self {
            if !result.contains(element) {
                result.append(element)
            }
        }
        return result
    }
}
