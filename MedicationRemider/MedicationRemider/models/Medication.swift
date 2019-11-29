//
//  Medication.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

class Medication {
    
    var id: String
    var name: String
    var description: String
    var status: MedicationStatus
    var takeType: TakeType
    var visitDoctorAt: Date
    var dose: Int
    var frequency: Int
    var createdAt: Date
    var updatedAt: Date
    
    // Days have completed this habit
    var repetitions: [Repetition]?
 
    // Hour and minute that notification will fired
    var reminders: [Reminder]?
    
    init() {
        self.id = ""
        self.name = ""
        self.description = ""
        self.status = MedicationStatus.New
        self.takeType = TakeType.AfterMeal
        self.visitDoctorAt = Date()
        self.dose = 0
        self.frequency = 0
        self.createdAt = Date()
        self.updatedAt = Date()
        self.reminders = [Reminder(reminderHour: 7, reminderMinute: 0, isTurnOn: true)]
    }
    
    init(id: String,
         name: String,
         description: String,
         takeType: TakeType,
         visitDoctorDate: Date,
         dose: Int,
         frequency: Int,
         createdDate: Date,
         updatedDate: Date,
         reminders: [Reminder]) {
        
        self.id = id
        self.name = name
        self.description = description
        self.status = MedicationStatus.New
        self.takeType = takeType
        self.visitDoctorAt = visitDoctorDate
        self.dose = dose
        self.frequency = frequency
        self.createdAt = createdDate
        self.updatedAt = updatedDate
        self.reminders = reminders
    }
}

