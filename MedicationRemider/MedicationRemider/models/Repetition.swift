//
//  Repetition.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

class Repetition {
    var repetitionId: String
    var createdDate: Date
    var status: MedicationStatus
    var medication: Medication
    
    init(repetitionId: String, createdDate: Date, status: MedicationStatus, medication: Medication) {
        self.repetitionId = repetitionId
        self.createdDate = createdDate
        self.status = status
        self.medication = medication
    }
}
