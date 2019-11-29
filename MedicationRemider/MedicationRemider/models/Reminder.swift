//
//  Reminder.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

class Reminder {
    var reminderId: String
    var reminderHour: Int
    var reminderMinute: Int
    var isTurnOn: Bool
    var medication: Medication?
    
    init(reminderHour: Int, reminderMinute: Int, isTurnOn: Bool) {
        self.reminderId = ""
        self.reminderHour = reminderHour
        self.reminderMinute = reminderMinute
        self.isTurnOn = isTurnOn
    }
    
    init(reminderId: String, reminderHour: Int, reminderMinute: Int, isTurnOn: Bool, medication: Medication) {
        self.reminderId = reminderId
        self.reminderHour = reminderHour
        self.reminderMinute = reminderMinute
        self.isTurnOn = isTurnOn
        self.medication = medication
    }
}
