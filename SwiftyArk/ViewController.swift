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
        
        manager.ticker(currency: .cad) { (error, ticker) in
            if let canadianTicker = ticker {
                print(canadianTicker)
            }
        }
        
 
    }
}

