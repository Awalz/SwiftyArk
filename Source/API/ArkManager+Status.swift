//
//  ArkManager+Status.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-18.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

extension ArkManager {
    
    // MARK: Status

    /**
     Request the sync `Status` information  of the client.
     
     - Parameter completionHandler: The callback called after attempted network request.
     - Parameter error: Optional eror.
     - Parameter status: Optional ``Status`.
     */
    public func syncStatus(completionHandler: @escaping(_ error: Error?, _ status: Status?) -> ()) {
        guard let url = URL(string: urlBase + ArkConstants.Routes.syncStatus) else {
            completionHandler(ApiError.urlError, nil)
            return
        }
        
        fetch(Status.self, from: url) { (error, statusResponse) in
            if let aError = error {
                completionHandler(aError, nil)
                return
            }
            if let status = statusResponse {
                completionHandler(nil, status)
            } else {
                completionHandler(ApiError.unknownError, nil)
            }
        }
    }
}
