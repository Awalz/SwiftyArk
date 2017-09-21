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
        let dataString = "{\"a\":\"\(address)\"}"
        let data = dataString.data(using: .isoLatin1, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")!
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("L", forKey: "inputCorrectionLevel")
        
        let qrcodeCIImage = filter.outputImage!
        
        let cgImage = CIContext(options:nil).createCGImage(qrcodeCIImage, from: qrcodeCIImage.extent)
        UIGraphicsBeginImageContext(CGSize(width: 500.0, height: 500.0))
        let context = UIGraphicsGetCurrentContext()
        context!.interpolationQuality = .none
        
        context?.draw(cgImage!, in: CGRect(x: 0.0,y: 0.0,width: context!.boundingBoxOfClipPath.width,height: context!.boundingBoxOfClipPath.height))
        
        let preImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let qrCodeImage = UIImage(cgImage: (preImage?.cgImage!)!, scale: 1.0/UIScreen.main.scale, orientation: .downMirrored)
        
        return qrCodeImage
    }
}
#endif



