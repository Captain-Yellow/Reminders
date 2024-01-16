//
//  MyList+CoreDataClass.swift
//  Reminders
//
//  Created by Mohammad Afshar on 10/01/2024.
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    var remindersArray: [Reminder] {
        return reminders?.allObjects.compactMap {
            ($0 as! Reminder)
        } ?? []
    }
}
