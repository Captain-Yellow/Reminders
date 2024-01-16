//
//  ReminderDetailView.swift
//  Reminders
//
//  Created by Mohammad Afshar on 11/01/2024.
//

import SwiftUI

struct ReminderDetailView: View {
    @Binding var reminder: Reminder
    @State var reminderConfig: ReminderEditConfig = ReminderEditConfig()
    @Environment(\.dismiss) private var dismiss
    @State var pp: String = ""
    private var isFormValid: Bool {
        !reminderConfig.title.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $reminderConfig.title)
                        TextField("Notes", text: $reminderConfig.notes ?? "")
                    }
                    
                    Section {
                        Toggle(isOn: $reminderConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundStyle(.red)
                        }
                        .tint(.yellow)
                        
                        if reminderConfig.hasDate {
                            DatePicker("Select Date", selection: $reminderConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $reminderConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundStyle(.blue)
                        }
                        .tint(.yellow)
                        
                        if reminderConfig.hasTime {
                            DatePicker("Select Time", selection: $reminderConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                    }
                    .onChange(of: reminderConfig.hasDate) { oldValue, newValue in
                        if newValue {
                            reminderConfig.reminderDate = Date()
                        }
                    }
                    .onChange(of: reminderConfig.hasTime) { oldValue, newValue in
                        if newValue {
                            reminderConfig.reminderTime = Date()
                        }
                    }
                    
                    Section {
                        NavigationLink {
                            SelectListView(selectList: $reminder.myList)
                        } label: {
                            HStack {
                                Text("List")
                                Spacer()
                                Text(reminder.myList?.name ?? ":D")
                            }
                        }

                    }
                }
                .onAppear {
                    reminderConfig = ReminderEditConfig(reminder: reminder)
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Details")
                            .font(.headline)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save") {
                            do {
                                let updatedReminder = try ReminderService.updateReminder(reminder: reminder, editConfig: reminderConfig)
                                if updatedReminder {
                                    if reminder.reminderDate != nil || reminder.reminderTime != nil {
                                        let notification = UserNotification(title: reminder.title, note: reminder.note, date: reminder.reminderDate, time: reminder.reminderTime)
                                        NotificationManager.scheduleNotification(userNotification: notification)
                                    }
                                }
                            } catch {
                                print(error)
                            }
                            dismiss()
                        }
                        .disabled(!isFormValid)
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Close") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
