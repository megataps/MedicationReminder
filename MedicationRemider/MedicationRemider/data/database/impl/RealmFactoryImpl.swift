//
//  RealmFactoryImpl.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/27/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

class RealmFactoryImpl: RealmFactory {
    let config: Realm.Configuration?
    
    init(config: Realm.Configuration) {
        self.config = config
    }
    
    init() {
        config = nil
    }
    
    func getRealm() throws -> Realm {
        do {
            return try config != nil ? Realm(configuration: config!) : Realm()
        } catch let error as NSError {
            Logger.log("LLLNNN>>>Create Realm error: \(error)")
            throw DataError.connectDatabaseError
        }
    }
    
    func getQuery<T: Object>() throws -> Results<T> {
        return try getRealm().objects(T.self)
    }
}
