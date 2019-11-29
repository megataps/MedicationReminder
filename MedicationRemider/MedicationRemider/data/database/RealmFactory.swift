//
//  RealmFactory.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/27/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmFactory {
    func getRealm() throws -> Realm
    func getQuery<T: Object>() throws -> Results<T>
}
