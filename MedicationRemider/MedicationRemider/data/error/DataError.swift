//
//  DataError.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/27/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

enum DataError: Error {
    case objectNotFound(id: String)
    case notFound
    case connectDatabaseError
}
