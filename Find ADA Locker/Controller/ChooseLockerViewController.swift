//
//  ChooseLockerViewController.swift
//  Find ADA Locker
//
//  Created by William Santoso on 18/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

protocol LockerDataDelegate {
    func getLockerData(locker: Locker)
}

class ChooseLockerViewController: UIViewController {
    
    @IBOutlet weak var chooseLockerCollectionView: UICollectionView!
    
    var zone: Zone = .zoneA
    var index: Int = 0
    var locker = Locker()
    var totalLocker: Int = 27
    var delegate: LockerDataDelegate?
    var lockerNumber = Int()
    
    var zoneString: [String] = ["A", "B", "C", "D"]
    
    let userDef = UserDefaults.standard
    var lockerNumbers: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        chooseLockerCollectionView.register(UINib(nibName: "ChooseLockerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ChooseLockerCollectionViewCell")
    }
}


extension ChooseLockerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch zone {
        case .zoneA:
            totalLocker = 27
        case .zoneB:
            totalLocker = 27
        case .zoneC:
            totalLocker = 54
        case .zoneD:
            totalLocker = 45
        }
        
        var index: Int = 0
        let maxColoum: Int = totalLocker / 3
        
        for i in 0...(totalLocker - 1) {
            let number = ((i / 3) + 1) + (maxColoum * index)
            lockerNumbers.insert(number, at: i)
            index += 1
            if index == 3 {
                index = 0
            }
        }
        
        return totalLocker
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = chooseLockerCollectionView.dequeueReusableCell(withReuseIdentifier: "ChooseLockerCollectionViewCell", for: indexPath) as! ChooseLockerCollectionViewCell
        let lockerNumber: Int = lockerNumbers[indexPath.row]
        
        let taken = userDef.string(forKey: "zone\(zoneString[index])Locker\(lockerNumber)")
        if taken == "taken" {
            cell.frontView.alpha = 1
        }else{
            cell.frontView.alpha = 0
        }
        
        cell.lockerNumberLabel.text = String(format: "%02d", lockerNumber)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lockerNumber = lockerNumbers[indexPath.row] //indexPath.row + 1
        let lockerNumberString: String =  String(format: "%02d", lockerNumbers[indexPath.row])
        let taken = userDef.string(forKey: "zone\(zoneString[index])Locker\(lockerNumbers[indexPath.row])")
        if taken == "taken" {
            let alertChoose = UIAlertController(title: "Locker", message: "Locker \(lockerNumberString) in \(zone.rawValue) has been taken", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "dismiss", style: .cancel) { (_) in
                
            }
            
            alertChoose.addAction(cancelAction)
            
            self.present(alertChoose, animated: true, completion: nil)
        } else {
            let alertChoose = UIAlertController(title: "Locker", message: "Do you want to choose your locker \(lockerNumber) in \(zone.rawValue)?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
                
            }
            let chooseAction = UIAlertAction(title: "Choose", style: .default) { (_) in
                let randomPasscode = Int.random(in: 0...999999)
                let passcodeString: String = String(format: "%06d", randomPasscode)
                let alertViewCode = UIAlertController(title: "Code", message: passcodeString, preferredStyle: .alert)
                
                let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: { (_) in
                    self.locker.ownership = "haveLocker"
                    print(self.index)
                    self.locker.zone = self.zone.rawValue
                    self.locker.lockerNumber = self.lockerNumber
                    self.locker.lockerCode = randomPasscode
                    
//                    print(self.locker.ownership)
//                    print(self.locker.zone)
//                    print(self.locker.lockerNumber)
//                    print(self.locker.lockerCode)
//                    
                    self.userDef.set(self.locker.ownership, forKey: "userOwnership")
                    self.userDef.set(self.locker.zone, forKey: "userZone")
                    self.userDef.set(self.locker.lockerNumber, forKey: "userLockerNumber")
                    self.userDef.set(self.locker.lockerCode, forKey: "userLockerCode")
                    
                    if self.delegate != nil {
                        self.delegate?.getLockerData(locker: self.locker)
                    }
                    
                    self.navigationController?.popToRootViewController(animated: true)
                })
                
                alertViewCode.addAction(dismissAction)
                
                self.present(alertViewCode, animated: true, completion: nil)
                
            }
            
            alertChoose.addAction(cancelAction)
            alertChoose.addAction(chooseAction)
            
            self.present(alertChoose, animated: true, completion: nil)
        }
        
        
    }
}
