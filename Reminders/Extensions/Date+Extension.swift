//
//  Date+Extension.swift
//  Reminders
//
//  Created by Mohammad Afshar on 11/01/2024.
//

import Foundation

extension Date {
    var isToday: Bool {
        let calender = Calendar.current
        return calender.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        let calender = Calendar.current
        return calender.isDateInTomorrow(self)
    }
    
    var dateComponents: DateComponents {
        Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
    }
}
