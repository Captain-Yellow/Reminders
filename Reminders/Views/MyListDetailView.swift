//
//  MyListDetailView.swift
//  Reminders
//
//  Created by Mohammad Afshar on 11/01/2024.
//

import SwiftUI
import CoreData

struct MyListDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State var addNewReminder: Bool = false
    @State var newReminderTitle: String = ""
    let list: MyList
    
    @FetchRequest(sortDescriptors: [])
    private var reminderResault: FetchedResults<Reminder>
    
    var isFormValid: Bool {
        newReminderTitle.isEmpty
    }
    
    init(myList: MyList) {
        self.list = myList
//        _reminderResault = FetchRequest(fetchRequest: Reminder.fetchRequest())
        _reminderResault = FetchRequest(fetchRequest: ReminderService.getRemindersByList(myList: myList))
    }
    
    var body: some View {
        VStack {
            ReminderListView(reminders: reminderResault)
            
            HStack {
                Image(systemName: "plus.circle.fill")
                
                Button("New Reminder") {
                    addNewReminder = true
                }
            }
            .foregroundStyle(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .alert("Add New Reminder", isPresented: $addNewReminder) {
            TextField("Title", text: $newReminderTitle)
            
            Button("Close", role: .cancel) { }
            
            Button("Done") {
                if !isFormValid {
                    do {
                        print("\n\n Saved \n\n")
                        try ReminderService.addReminderToMyList(myList: list, reminderTitle: newReminderTitle)
                    } catch {
                        print("\n\n Ops \n\n")
                        print(error.localizedDescription)
                    }
                } else {
                    print("save reminders falied, empty field")
                }
            }
//            .disabled(isFormValid)
        }
    }
}


#Preview {
    MyListDetailView(myList: PreviewData.myList)
}
