//
//  ViewController.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-16.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // "AYdHH5TsZF796pv7gxVU1tK6DLkUxMK1VL"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = ArkManager()
        manager.account(address: "AYdHH5TsZF796pv7gxVU1tK6DLkUxMK1VL") { (error, account) in
            if let a = account {
                manager.updateSettings(account: a)
                manager.publicKey(completionHandler: { (error, publickey) in
                    print(error)
                    print(publickey)
                })
                
            }
        }
    }
}

