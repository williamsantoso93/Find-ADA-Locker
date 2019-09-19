//
//  ChooseLockerViewController.swift
//  Find ADA Locker
//
//  Created by William Santoso on 18/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class ChooseLockerViewController: UIViewController {
    
    @IBOutlet weak var chooseLockerCollectionView: UICollectionView!
    
    var zone: Zone = .zoneA
    var totalLocker: Int = 27
    
    let userDef = UserDefaults.standard
    
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
        return totalLocker
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = chooseLockerCollectionView.dequeueReusableCell(withReuseIdentifier: "ChooseLockerCollectionViewCell", for: indexPath) as! ChooseLockerCollectionViewCell
        let lockerNumber: Int = indexPath.row + 1
        cell.lockerNumberLabel.text = String(format: "%02d", lockerNumber)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lockerNumber: Int = indexPath.row + 1
        let alertChoose = UIAlertController(title: "Locker", message: "Do you want to choose your locker \(lockerNumber) in \(zone.rawValue)?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
        }
        let chooseAction = UIAlertAction(title: "Choose", style: .default) { (_) in
            
            let alertViewCode = UIAlertController(title: "Code", message: <#T##String?#>, preferredStyle: <#T##UIAlertController.Style#>)
            
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        alertChoose.addAction(cancelAction)
        alertChoose.addAction(chooseAction)
        
        self.present(alertChoose, animated: true, completion: nil)
    }
}
