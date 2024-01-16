//
//  ReminderCellView.swift
//  Reminders
//
//  Created by Mohammad Afshar on 11/01/2024.
//

import SwiftUI

struct ReminderCellView: View {
    let reminder: Reminder
    let showInfoButton: Bool
    let delayTask = DelayTask()
    let onEvent: (ReminderCellEvents) -> Void
    @State var isCompleted: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: isCompleted ? "circle.inset.filled" : "circle")
                .font(.title2)
                .opacity(0.4)
                .onTapGesture {
                    isCompleted.toggle()
                    
                    delayTask.cancelDelayedTask()
                    delayTask.performDelayedTask {
                        onEvent(.onCheckedChange(reminder, isCompleted))
                    }
                }
            
            VStack(alignment: .leading) {
                Text(reminder.title ?? "")
                if let note = reminder.note, !note.isEmpty {
                    Text(note)
                        .font(.caption)
                        .opacity(0.4)
                }
                
                HStack {
                    if let reminderDate = reminder.reminderDate {
                        Text(formatDate(reminderDate))
                    }
                    
                    if let reminderTime = reminder.reminderTime {
                        Text(reminderTime.formatted(date: .omitted, time: .shortened))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(0.4)
                .font(.caption)
            }
            
            Spacer()
            
            Image(systemName: "info.circle.fill")
                .opacity(showInfoButton ? 1.0 : 0.0)
                .onTapGesture {
                    onEvent(.onInfo)
                }
        }
        .onAppear {
            isCompleted = reminder.isCompleted
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onEvent(.onSelect(reminder))
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
}

enum ReminderCellEvents {
    case onInfo
    case onCheckedChange(Reminder, Bool)
    case onSelect(Reminder)
}

#Preview {
    ReminderCellView(reminder: PreviewData.reminder, showInfoButton: false, onEvent: {_ in })
}
