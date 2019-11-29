//
//  NotificationScheduleManager.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import SwifterSwift

class NotificationScheduleManager {
    
    static func clearAllNotification() {
        let scheduler = DLNotificationScheduler()
        scheduler.cancelAlllNotifications()
    }
    
    static func printAllNotifications() {
        let scheduler = DLNotificationScheduler()
        scheduler.printAllNotifications()
    }
    
    static func createNotification(_ medication: Medication) {
        if medication.reminders?.count == 0 {
            return
        }
        
        let scheduler = DLNotificationScheduler()
        
        let currentDate = Date()
        
        for reminder in medication.reminders! {
            let fireDate = currentDate.setTimeWithLocalTimeZone(hour: reminder.reminderHour, min: reminder.reminderMinute, sec: 0)
            let identifier = createDailyIdentifier(medication.id, hour: reminder.reminderHour, minute:reminder.reminderMinute)
            
            let firstNotification = DLNotification(identifier: identifier,
                                                   alertTitle: Strings.AppName.localize(),
                                                   alertBody: medication.name,
                                                   date: fireDate,
                                                   repeats: .daily)
            
            scheduler.scheduleNotification(notification: firstNotification)
        }
   
        
        scheduler.scheduleAllNotifications()
    }
    
    static func deleteNotification(_ medication: Medication) {
        let scheduler = DLNotificationScheduler()
        
        for reminder in medication.reminders! {
            let identifier = createDailyIdentifier(medication.id, hour: reminder.reminderHour, minute:reminder.reminderMinute)
            scheduler.cancelNotificationWithIdentifier(identifier)
        }
        
    }
}

private extension NotificationScheduleManager {
    
    static func createDailyIdentifier(_ id: String, hour: Int, minute: Int) -> String {
        return "MG_PUSH_\(id)_\(hour)#\(minute)"
    }
    
    static func createWeeklyIdentifier(_ id: String, weekday: String, hour: Int, minute: Int) -> String {
        return "MG_PUSH_\(id)_\(weekday)_\(hour)#\(minute)"
    }
    
    static func createDate(weekday: Int, date: Date) -> Date{
        
        var components = DateComponents()
        components.hour = date.hour
        components.minute = date.minute
        components.month = date.month
        components.year = date.year
        components.weekday = weekday // sunday = 1 ... saturday = 7
        components.weekdayOrdinal = date.weekOfMonth
        components.timeZone = .current
        
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: components)!
    }
    
    static func getWeekDay(_ weekday: String) -> Int {
        if (weekday.lowercased() == "sunday") {
            return 1
        } else if (weekday.lowercased() == "monday") {
            return 2
        } else if (weekday.lowercased() == "tuesday") {
            return 3
        } else if (weekday.lowercased() == "wednesday") {
            return 4
        } else if (weekday.lowercased() == "thursday") {
            return 5
        } else if (weekday.lowercased() == "friday") {
            return 6
        } else {
            return 7
        }
    }
}
