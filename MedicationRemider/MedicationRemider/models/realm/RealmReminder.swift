//
//  RealmReminder.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

class RealmReminder: RealmModel, TransformerDAO {
        
    static let Columns = (
        reminderId: "reminderId",
        reminderHour: "reminderHour",
        reminderMinute: "reminderMinute",
        isTurnOn: "isTurnOn",
        medication: "medication"
    )
    
    @objc dynamic var reminderId: String! = ""
    @objc dynamic var reminderHour = 0
    @objc dynamic var reminderMinute = 0
    @objc dynamic var isTurnOn = false
    @objc dynamic var medication: RealmMedication?
    
    override static func primaryKey() -> String? {
        return Columns.reminderId
    }
    
    static func fromModel(_ reminder: Reminder) -> RealmReminder {
        let realmReminder = RealmReminder()
        realmReminder.reminderId = reminder.reminderId == "" ? realmReminder.newId() : reminder.reminderId
        realmReminder.reminderHour = reminder.reminderHour
        realmReminder.reminderMinute = reminder.reminderMinute
        realmReminder.isTurnOn = reminder.isTurnOn
        realmReminder.medication = RealmMedication.fromModel(reminder.medication!)
        
        return realmReminder
    }
    
    class func toModel(_ d: RealmReminder) -> Reminder {
        return d.toModel()
    }
    
    func toModel() -> Reminder {
        let reminder = Reminder(reminderId: reminderId, reminderHour: reminderHour, reminderMinute: reminderMinute, isTurnOn: isTurnOn, medication: RealmMedication.toModel(medication!))
        return reminder
    }
}
