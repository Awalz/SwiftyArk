//
//  ViewController.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-16.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = ArkManager()
        
        manager.transaction(id: "5b26edc0ce38c882752e751cd62a0d0e8d256e40736f9d5f52baffd58961da1d") { (error, transaction) in
            print(error)
            print(transaction)
        }
    }
}

