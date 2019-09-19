//
//  Extention.swift
//  Find ADA Locker
//
//  Created by William Santoso on 18/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

extension UIButton {
    func fullRound() {
        self.layer.cornerRadius = self.layer.frame.width / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}

extension UIView {
    func rounded() {
        self.layer.cornerRadius = 5
    }
}
