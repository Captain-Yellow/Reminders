//
//  CoreDataProvider.swift
//  Reminders
//
//  Created by Mohammad Afshar on 10/01/2024.
//

import Foundation
import CoreData

class CoreDataProvider {
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer
    
    init() {
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))
        
        persistentContainer = NSPersistentContainer(name: "RemindersModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("FATAL ERROR: can not load persistent data \(error.localizedDescription)")
            }
        }
    }
}
