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
    var ownership: String = "finding"
    var zone: String = "Zone A"
    var lockerNumber: Int = 1
    var lockerCode: Int = 000000
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(ownership, forKey: "userOwnership")
//        aCoder.encode(zone, forKey: "userZone")
//        aCoder.encode(lockerNumber, forKey: "userLockerNumber")
//        aCoder.encode(lockerCode, forKey: "userLockerCode")
//    }
//
//    required convenience init(coder aDecoder: NSCoder) throws {
//        let ownership = aDecoder.decodeObject(forKey: "userOwnership")
//        let zone = aDecoder.decodeObject(forKey: "userZone")
//        let lockerNumber = aDecoder.decodeCInt(forKey: "userLockerNumber")
//        let lockerCode = aDecoder.decodeCInt(forKey: "userLockerCode")
//
//        self.init(ownership: ownership, zone: zone, lockerNumber: lockerNumber, lockerCode: lockerCode)
//    }
}
