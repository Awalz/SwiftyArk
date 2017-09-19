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
    
    // jarunik: 02c7455bebeadde04728441e0f57f82f972155c088252bf7c1365eb0dc84fbf5de

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = ArkManager()
        manager.delegate("jarunik") { (error, delegate) in
            if let a = delegate {
                print(a)

            }
        }
    }
}

