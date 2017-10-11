//
//  ArkManager+Ticker.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-18.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

extension ArkManager {
    
    // MARK: Ticker

    /**
     Request an `ArkTicker` object in specified currency
     
     - Parameter currency: requested `Currency`
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional eror.
     - Parameter ticker: Optional `ArkTicker`.
     */
    public func ticker(currency: Currency, completionHandler: @escaping(_ error: Error?, _ ticker: Ticker?) -> ()) {
        guard let url = URL(string: ArkConstants.Routes.arkTicker(currency)) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        makeNetworkRequest(url: url) { (error, data) in
            if let aError = error {
                completionHandler(aError, nil)
            } else if let aData = data {
                if let ticker = Ticker(currency: currency, data: aData) {
                    completionHandler(nil, ticker)
                } else {
                    completionHandler(ApiError.unknownError, nil)
                }
            }
        }
    }
}
