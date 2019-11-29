//
//  RealmModel.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

class RealmModel: Object {
    static let LocalIdPrefix = "#LOCAL_"
    
    @objc dynamic var createdAt: Date = Date().setTime(hour: 0, min: 0, sec: 0)!
    @objc dynamic var updatedAt: Date = Date().setTime(hour: 0, min: 0, sec: 0)!
    
    static let hashids = Hashids(salt: "MR_ID_GENERATOR")
    static let IdPrefix = RealmModel.LocalIdPrefix
    
    func newId() -> String {
        let random1 = Int(arc4random_uniform(UInt32(Int32.max)))
        let random2 = Int(arc4random_uniform(UInt32(Int32.max)))
        let random3 = Int(arc4random_uniform(UInt32(Int32.max)))
        return "\(getIdPrefix() + RealmModel.hashids.encode(random1, random2, random3)!)"
    }
    
    func getIdPrefix() -> String {
        return RealmModel.IdPrefix
    }
    
    func isLocal(_ id: String) -> Bool {
        return id.hasPrefix(RealmModel.IdPrefix)
    }
}
