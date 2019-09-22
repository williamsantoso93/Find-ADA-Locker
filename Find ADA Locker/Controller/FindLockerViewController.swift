//
//  ViewController.swift
//  Find ADA Locker
//
//  Created by William Santoso on 18/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit
import LocalAuthentication
import SystemConfiguration.CaptiveNetwork

class FindLockerViewController: UIViewController {

    @IBOutlet weak var findLockerButton: UIButton!
    @IBOutlet weak var zoneLabel: UILabel!
    @IBOutlet weak var lockerNumberLabel: UILabel!
    
    let userDef = UserDefaults.standard
    var locker = Locker() {
        didSet {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        locker.ownership = .haveLocker
//        locker = userDef.object(forKey: <#T##String#>)
        loadUserData()
        checkStatus()
        loadDummyData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadUserData()
        checkStatus()
    }
    
    func loadDummyData() {
        var isDummyData = userDef.bool(forKey: "isDummyData")
//        print(isDummyData)
        if !isDummyData {
            isDummyData = true
            self.userDef.set(isDummyData, forKey: "isDummyData")
            
            let zone: [String] = ["A", "B", "C", "D"]
            let totalLocker: [Int] = [27, 27, 54, 45]
            for i in 0...3 {
                for _ in 0...(totalLocker[i] - 1) {
                    let random: Int = Int.random(in: 1...totalLocker[i])
                    let key: String = "zone\(zone[i])Locker\(random)"
//                    print(key)
                    
                    self.userDef.set("taken", forKey: key)
                }
            }
        }
        
    }
    
    func checkStatus() {
        DispatchQueue.main.async {
            switch self.locker.ownership {
            case "finding":
                self.findLockerButton.setTitle("Find Locker", for: .normal)
                self.findLockerButton.setImage(UIImage(), for: .normal)
//                self.findLockerButton.setBackgroundImage(UIImage(), for: .normal)
                self.findLockerButton.fullRound()
                self.zoneLabel.alpha = 0
                self.lockerNumberLabel.alpha = 0
            case "haveLocker":
                self.zoneLabel.text = self.locker.zone
                self.zoneLabel.alpha = 1
                self.lockerNumberLabel.text = "\(self.locker.lockerNumber)"
                self.lockerNumberLabel.alpha = 1
                self.findLockerButton.setTitle("", for: .normal)
//                self.findLockerButton.setBackgroundImage(#imageLiteral(resourceName: "Locker"), for: .normal)
                self.findLockerButton.setImage(#imageLiteral(resourceName: "Locker"), for: .normal)
                self.findLockerButton.layer.borderWidth = 0
            default:
                break
            }
        }
    }
    func touchIdAction() {
        
        let myContext = LAContext()
        let myLocalizedReasonString = "Biometric Authntication testing !! "
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    
                    DispatchQueue.main.async {
                        if success {
                            // User authenticated successfully, take appropriate action
                            self.setupData()
                        } else {
                            // User did not authenticate successfully, look at error and take appropriate action
                            
                        }
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
                
            }
        } else {
            // Fallback on earlier versions
            
        }
    }
    
    func setupData() {
        DispatchQueue.main.async {
            switch self.locker.ownership {
            case "finding":
                self.performSegue(withIdentifier: "ChooseZone", sender: self)
            case "haveLocker":
                self.haveUnlock()
            default:
                break
            }
        }
    }
    
    func haveUnlock() {
        let alertHaveUnlock = UIAlertController(title: "Unlock", message: "Do you want to unlock your locker??", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
        }
        let unlockAction = UIAlertAction(title: "Unlock", style: .default) { (_) in
            let passcode = self.locker.lockerCode
            let passcodeString: String = String(format: "%06d", passcode)
            let alertViewCode = UIAlertController(title: "Code", message: passcodeString, preferredStyle: .alert)
            
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: { (_) in
                self.locker.ownership = "finding"
                self.locker.zone = "Zone A"
                self.locker.lockerNumber = 0
                self.locker.lockerCode = 0
                
                self.userDef.set(self.locker.ownership, forKey: "userOwnership")
                self.userDef.set(self.locker.zone, forKey: "userZone")
                self.userDef.set(self.locker.lockerNumber, forKey: "userLockerNumber")
                self.userDef.set(self.locker.lockerCode, forKey: "userLockerCode")
                self.checkStatus()
            })
            
            alertViewCode.addAction(dismissAction)
            
            self.present(alertViewCode, animated: true, completion: nil)
            
        }
//        let viewCodeAction = UIAlertAction(title: "Unlock", style: .default) { (_) in
//            let randomPasscode = Int.random(in: 0...99999)
//            let passcodeString: String = String(format: "%06d", randomPasscode)
//            let alertViewCode = UIAlertController(title: "Code", message: passcodeString, preferredStyle: .alert)
//
//            let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: { (_) in
//
//            })
//
//            alertViewCode.addAction(dismissAction)
//
//            self.present(alertViewCode, animated: true, completion: nil)
//
//        }
        
        alertHaveUnlock.addAction(unlockAction)
        alertHaveUnlock.addAction(cancelAction)
        
        self.present(alertHaveUnlock, animated: true, completion: nil)
    }
    
    func loadUserData() {
//        let imageData = userDef.object(forKey: "image")
//        save
//        userDef.set(email, forKey: "email")
//        userDef.set(address, forKey: "address")
        let userOwnership = userDef.string(forKey: "userOwnership") ?? "finding"
        let userZone = userDef.string(forKey: "userZone") ?? "Zone A"
        let userLockerNumber = userDef.integer(forKey: "userLockerNumber")
        let userLockerCode = userDef.integer(forKey: "userLockerCode")
        
        locker.ownership = userOwnership
        locker.zone = userZone
        locker.lockerNumber = userLockerNumber
        locker.lockerCode = userLockerCode
        
//        print(userOwnership)
//        print(userZone)
//        print(userLockerNumber)
//        print(userLockerCode)
    }
    

    @IBAction func findLockerButtonDidTap(_ sender: Any) {
//        let wifiSSID: String = fetchSSIDInfo()
//        if wifiSSID == "iosda-training" {
//            touchIdAction()
//        } else {
//            let alertViewCode = UIAlertController(title: "Friend", message: "Your are not connected to iosda-training wifi", preferredStyle: .alert)
//            
//            let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: { (_) in
//                
//            })
//            
//            alertViewCode.addAction(dismissAction)
//            
//            self.present(alertViewCode, animated: true, completion: nil)
//            
//        }
    }
    
    func fetchSSIDInfo() ->  String {
        var currentSSID = ""
        if let interfaces:CFArray = CNCopySupportedInterfaces() {
            for i in 0..<CFArrayGetCount(interfaces){
                let interfaceName: UnsafeRawPointer = CFArrayGetValueAtIndex(interfaces, i)
                let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
                let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)" as CFString)
                if unsafeInterfaceData != nil {
                    let interfaceData = unsafeInterfaceData! as Dictionary?
                    for dictData in interfaceData! {
                        if dictData.key as! String == "SSID" {
                            currentSSID = dictData.value as! String
                        }
                    }
                }
            }
        }
        return currentSSID
    }

}

extension FindLockerViewController: LockerDataDelegate {
    func getLockerData(locker: Locker) {
        self.locker = locker
//        print("current locker data:")
//        print(self.locker)
    }
}
