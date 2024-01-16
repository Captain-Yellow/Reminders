//
//  MyList+CoreDataProperties.swift
//  Reminders
//
//  Created by Mohammad Afshar on 10/01/2024.
//

import Foundation
import UIKit
import CoreData

extension MyList {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyList> {
        return NSFetchRequest<MyList>(entityName: "MyList")
    }
    
    @NSManaged public var name: String
    @NSManaged public var color: UIColor
    @NSManaged public var reminders: NSSet?
}

extension MyList: Identifiable {
    
}

// MARK: - Generated accessors for notes
extension MyList {
    
    @objc(addRemindersObject:)
    @NSManaged func addToReminders(_ value: Reminder)
    
    @objc(removeRemindersObject:)
    @NSManaged func removeFromReminders(_ value: Reminder)
    
    @objc(addReminders:)
    @NSManaged func addToReminders(_ value: NSSet)
    
    @objc(removeReminders:)
    @NSManaged func removeFromReminders(_ value: NSSet)
}
