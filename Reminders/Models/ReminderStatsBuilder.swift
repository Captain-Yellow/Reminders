//
//  ReminderStatsBuilder.swift
//  Reminders
//
//  Created by Mohammad Afshar on 15/01/2024.
//

import Foundation
import SwiftUI


enum ReminderStateType {
    case all
    case today
    case scheduled
    case completed
}

struct ReminderStatsValues {
    var allTasks: Int = 0
    var scheduledTasks: Int = 0
    var completedTasks: Int = 0
    var todayTasks: Int = 0
}

struct ReminderStatsBuilder {
    func build(_ myList: FetchedResults<MyList>) -> ReminderStatsValues {
        let allReminders = myList.map {
            $0.remindersArray
        }
            .reduce([], +)
        
        return ReminderStatsValues(allTasks: calulateAllCount(reminders: allReminders),
                                   scheduledTasks: calculateAllScheduledCount(reminders: allReminders),
                                   completedTasks: calulateAllComplated(reminders: allReminders),
                                   todayTasks: calculateTodayTasks(reminders: allReminders))
    }
    
    private func calulateAllCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { partialResult, reminder in
            return !reminder.isCompleted ? partialResult + 1 : partialResult
        }
    }
    
    private func calculateTodayTasks(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { partialResult, reminder in
            let isTodey = reminder.reminderDate?.isToday ?? false
            return isTodey ? partialResult + 1 : partialResult
        }
    }
    
    private func calulateAllComplated(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { partialResult, reminder in
            return reminder.isCompleted ? partialResult + 1 : partialResult
        }
    }
    
    private func calculateAllScheduledCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { partialResult, reminder in
            return (reminder.reminderDate != nil || reminder.reminderTime != nil) ? partialResult + 1 : partialResult
        }
    }
}
