//
//  ViewController.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-16.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate    var delegates: [Delegate] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.isHidden = true
        
        let manager = ArkManager()
        manager.account(address: "AYdHH5TsZF796pv7gxVU1tK6DLkUxMK1VL") { (errror, account) in
            if let a = account {
                if let qr = a.qrCode() {
                    let imageView = UIImageView(image: qr)
                    imageView.frame = CGRect(x: 30.0, y: 30.0, width: 200.0, height: 200.0)
                    self.view.addSubview(imageView)
                }
            }
        }

        manager.delegates { (error, delegates) in
            if let aError = error {
                print(aError)
                return
            }
            
            if let currentDelegates = delegates {
                self.delegates = currentDelegates
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: UITableViewDataSource
extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let delegate = delegates[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(delegate.rate). \(delegate.username)"
        return cell
    }
    
    
}

