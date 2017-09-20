//
//  Account+iOS.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-20.
//  Copyright © 2017 Walzy. All rights reserved.
//


#if os(iOS)
import UIKit
import CoreImage
#endif

#if os(iOS)
public extension Account {
    
    public func qrCode() -> UIImage? {
        let data = address.data(using: .isoLatin1, allowLossyConversion: false)
        
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("Q", forKey: "inputCorrectionLevel")
        
        if let outputImage = filter.outputImage {
            return UIImage(ciImage: outputImage)
        } else {
            return nil
        }
    }
}
#endif



