//
//  Date+Extension.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

extension Date {

    public func setTime(hour: Int, min: Int, sec: Int, timeZoneAbbrev: String = "UTC") -> Date? {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)
        
        components.timeZone = TimeZone(abbreviation: timeZoneAbbrev)
        components.hour = hour
        components.minute = min
        components.second = sec
        
        return cal.date(from: components)
    }
    
    public func setTimeWithLocalTimeZone(hour: Int, min: Int, sec: Int) -> Date? {
        let cal = Calendar.current
        var components = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        
        let timeZoneString = TimeZone.current.abbreviation()
        components.timeZone = TimeZone(abbreviation: timeZoneString!)
        
        components.hour = hour
        components.minute = min
        components.second = sec
        
        return cal.date(from: components)
    }
    
    func toDateStringOnly(format: String = "yyyy MMM dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    func compareDateOnly(withDate: Date) -> Bool {
        let date = self.toDateStringOnly(format: "yyyy-MM-dd")
        let compDate = withDate.toDateStringOnly(format:"yyyy-MM-dd")
        return date == compDate
    }
}
