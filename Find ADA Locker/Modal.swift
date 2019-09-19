//
//  Modal.swift
//  Find ADA Locker
//
//  Created by William Santoso on 18/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import Foundation

enum Ownership {
    case finding
    case haveLocker
}

enum Zone: String {
    case zoneA = "Zone A"
    case zoneB = "Zone B"
    case zoneC = "Zone C"
    case zoneD = "Zone D"
}

class Locker {
    var ownership: Ownership = .finding
    var zone: Zone = .zoneA
    var lockerNumber: Int = 1
    var lockerCode: Int = 000000
}

