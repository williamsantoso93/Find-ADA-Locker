//
//  ViewController.swift
//  Find ADA Locker
//
//  Created by William Santoso on 18/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class FindLockerViewController: UIViewController {

    @IBOutlet weak var findLockerButton: UIButton!
    
    let userDef = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        findLockerButton.fullRound()
    }
    
    
    func loadUserData() {
//        let imageData = userDef.object(forKey: "image")
//        save
//        userDef.set(email, forKey: "email")
//        userDef.set(address, forKey: "address")
    }
    

    @IBAction func findLockerButtonDidTap(_ sender: Any) {
        print("hello")
        performSegue(withIdentifier: "ChooseZone", sender: self)
    }
    
}

