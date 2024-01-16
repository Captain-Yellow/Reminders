//
//  ReminderService.swift
//  Reminders
//
//  Created by Mohammad Afshar on 10/01/2024.
//

import Foundation
import UIKit
import CoreData
import SwiftUI


class ReminderService {
    static var context: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    class func save() throws {
        try context.save()
    }
    
    static func saveMyList(_ name: String, _ color: UIColor) throws -> Void {
        let myList = MyList(context: context)
        myList.name = name
        myList.color = color
        try save()
    }
    
    static func addReminderToMyList(myList: MyList, reminderTitle: String) throws -> Void {
        let reminder = Reminder(context: context)
        reminder.title = reminderTitle
        myList.addToReminders(reminder)
        try save()
    }
    
    static func getRemindersByList(myList: MyList) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "myList == %@ AND isCompleted == false", myList)
        return request
    }
    
    static func updateReminder(reminder: Reminder, editConfig: ReminderEditConfig) throws -> Bool {
        let reminderToUpdate = reminder
        reminderToUpdate.isCompleted = editConfig.isCompleted
        reminderToUpdate.title = editConfig.title
        reminderToUpdate.note = editConfig.notes
        reminderToUpdate.reminderDate = editConfig.hasDate ? editConfig.reminderDate : nil
        reminderToUpdate.reminderTime = editConfig.hasTime ? editConfig.reminderTime : nil
        print("\n\nDate '\(editConfig.hasDate)' -> \(String(describing: editConfig.reminderDate))")
        print("Time '\(editConfig.hasTime)' -> \(String(describing: editConfig.reminderTime)) \n")
        print("-> \(reminder.objectID) Reminder ObjID")
        print("-> \(reminderToUpdate.objectID) ReminderToUpdate ObjID\n\n")
        //        reminderToUpdate.reminderTime = editConfig.reminderTime
        try save()
        return true
    }
    
    static func deleteReminder(_ reminder: Reminder) throws {
        context.delete(reminder)
        try save()
    }
    
    static func getRemindersBySearchTerm(_ searchTerm: String) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchTerm)
        return request
    }
    
    static func remindersByStatType(statType: ReminderStateType) -> NSFetchRequest<Reminder> {
        
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        
        switch statType {
            case .all:
                request.predicate = NSPredicate(format: "isCompleted = false")
            case .today: // THIS PART HAS BEEN UPDATED
                let today = Date()
                let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
//                request.predicate = NSPredicate(format: "(reminderDate BETWEEN {%@, %@}) OR (reminderTime BETWEEN {%@, %@})", today as NSDate, tomorrow! as NSDate)
                 request.predicate = NSPredicate(format: "(reminderDate >= %@) AND (reminderDate < %@)", today as NSDate, tomorrow! as NSDate )
            case .scheduled:
                request.predicate = NSPredicate(format: "(reminderDate != nil OR reminderTime != nil) AND isCompleted = false")
            case .completed:
                request.predicate = NSPredicate(format: "isCompleted = true")
        }
        
        return request
    }
}
