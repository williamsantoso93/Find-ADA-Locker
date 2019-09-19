//
//  ChooseLockerCollectionViewCell.swift
//  Find ADA Locker
//
//  Created by William Santoso on 18/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class ChooseLockerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lockerNumberLabel: UILabel!
    @IBOutlet weak var frontView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        frontView.layer.cornerRadius = 8
    }

}
