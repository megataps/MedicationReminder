//
//  MedicationStatus.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

enum MedicationStatus {
    case New
    case Done
    case Overdue
}

extension MedicationStatus {
    
    init?(string: String) {
        switch string.lowercased() {
        case "new": self = .New
        case "done": self = .Done
        case "overdue": self = .Overdue
        default: return nil
        }
    }
    
    var codeString: String {
        switch self {
        case .New: return "new"
        case .Done: return "done"
        case .Overdue: return "overdue"
        
        }
    }
    
    var string: String {
        switch self {
        case .New: return Strings.MedicationStatusNew.localize()
        case .Done: return Strings.MedicationStatusDone.localize()
        case .Overdue: return Strings.MedicationStatusOverdue.localize()
        }
    }
}
