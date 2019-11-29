//
//  Operator.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

enum Operator: String {
    case Equal = "=="
    case GreaterThanOrEqual = ">="
    case LessThanOrEqual = "<="
    case Like = "CONTAINS[c]"
    case In = "IN"
}
