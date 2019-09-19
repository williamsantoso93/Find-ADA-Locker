//
//  ChooseZoneViewController.swift
//  Find ADA Locker
//
//  Created by William Santoso on 18/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class ChooseZoneViewController: UIViewController {

    @IBOutlet weak var chooseZoneCollectionView: UICollectionView!
    
    var index: Int = 0 {
        didSet {
            switch index {
            case 0:
                zone = .zoneA
            case 1:
                zone = .zoneB
            case 2:
                zone = .zoneC
            case 3:
                zone = .zoneD
            default:
                zone = .zoneA
            }
        }
    }
    
    var zoneString: [String] = ["A", "B", "C", "D"]
    var zone: Zone = .zoneA
    
    let userDef = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chooseZoneCollectionView.register(UINib(nibName: "ChooseZoneCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ChooseZoneCollectionViewCell")
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChooseLocker" {
            let controller = segue.destination as! ChooseLockerViewController
//            controller.index = index
            controller.zone = zone
        }
    }
}

extension ChooseZoneViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = chooseZoneCollectionView.dequeueReusableCell(withReuseIdentifier: "ChooseZoneCollectionViewCell", for: indexPath) as! ChooseZoneCollectionViewCell
        
        cell.zoneLabel.text = "Zone \(zoneString[indexPath.row])"
        cell.background.rounded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        print(index)
        performSegue(withIdentifier: "ChooseLocker", sender: self)
    }
}
