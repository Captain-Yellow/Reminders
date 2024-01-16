//
//  ReminderListView.swift
//  Reminders
//
//  Created by Mohammad Afshar on 11/01/2024.
//

import SwiftUI

struct ReminderListView: View {
    let reminders: FetchedResults<Reminder>
    @State var selectedReminder: Reminder?
    @State var showReminderDetailView: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach(reminders) { reminder in
                    ReminderCellView(reminder: reminder, showInfoButton: isReminderSelected(reminder)) { event in
                        switch event {
                            case .onInfo:
                                showReminderDetailView = true
                            case .onCheckedChange(let reminder, let isCompleted):
                                reminderCheckedChange(reminder: reminder, isCompleted: isCompleted)
                            case .onSelect(let reminder):
                                selectedReminder = reminder
                        }
                    }
                }
                .onDelete(perform: deleteReminder)
            }
        }
        .sheet(isPresented: $showReminderDetailView) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
    
    func deleteReminder(_ offset: IndexSet) {
        offset.forEach { index in
            do {
                try ReminderService.deleteReminder(reminders[index])
            } catch {
                print(error)
            }
        }
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        reminder.objectID == selectedReminder?.objectID
//        reminder === selectedReminder
    }
    
    private func reminderCheckedChange(reminder: Reminder, isCompleted: Bool) {
        var reminderEditConfig = ReminderEditConfig(reminder: reminder)
        reminderEditConfig.isCompleted = isCompleted /*!reminder.isCompleted*/
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: reminderEditConfig)
        } catch {
            print(error)
        }
    }
}

//#Preview {
//    ReminderListView()
//}
