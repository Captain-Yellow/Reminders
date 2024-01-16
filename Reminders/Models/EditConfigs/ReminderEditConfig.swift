//
//  ReminderEditConfig.swift
//  Reminders
//
//  Created by Mohammad Afshar on 12/01/2024.
//

import Foundation

struct ReminderEditConfig {
    var title: String = ""
    var notes: String?
    var isCompleted: Bool = false
    var hasDate: Bool = false
    var hasTime: Bool = false
    var reminderDate: Date?
    var reminderTime: Date?
    
    init () { }
    
    init (reminder: Reminder) {
        title = reminder.title ?? ""
        notes = reminder.note ?? ""
        isCompleted = reminder.isCompleted
        reminderDate = reminder.reminderDate// ?? Date()
        reminderTime = reminder.reminderTime// ?? Date()
        hasDate = reminder.reminderDate != nil
        hasTime = reminder.reminderTime != nil
    }
}
