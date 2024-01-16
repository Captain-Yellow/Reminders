//
//  MainView.swift
//  Reminders
//
//  Created by Mohammad Afshar on 10/01/2024.
//

import SwiftUI
import CoreData

struct MainView: View {
    @FetchRequest(sortDescriptors: [])
    private var myListResaults: FetchedResults<MyList>
    
    @FetchRequest(sortDescriptors: [.init(key: "title", ascending: true)])
    private var reminderSearchResault: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .today))
    private var todayRemindersResault: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .all))
    private var allRemindersResault: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .scheduled))
    private var scheduledRemindersResault: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .completed))
    private var completedRemindersResault: FetchedResults<Reminder>
    
    @State private var addNewList: Bool = false
    @State private var searchingContent: String = ""
    @State private var isSearching: Bool = false
    @State private var reminderStatsValues = ReminderStatsValues()
    private let reminderStatsBuilder = ReminderStatsBuilder()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        NavigationLink {
                            ReminderListView(reminders: todayRemindersResault)
                        } label: {
                            ReminderStatsView(iconName: "calendar", iconColor: .red, counter: reminderStatsValues.todayTasks, title: "Today")
                        }

                        NavigationLink {
                            ReminderListView(reminders: allRemindersResault)
                        } label: {
                            ReminderStatsView(iconName: "tray.circle.fill", iconColor: .blue, counter: reminderStatsValues.allTasks, title: "All")
                        }
                    }
                    
                    HStack {
                        NavigationLink {
                            ReminderListView(reminders: scheduledRemindersResault)
                        } label: {
                            ReminderStatsView(iconName: "calendar.circle.fill", iconColor: .secondary, counter: reminderStatsValues.scheduledTasks, title: "Scheduled")
                        }
                        NavigationLink {
                            ReminderListView(reminders: completedRemindersResault)
                        } label: {
                            ReminderStatsView(iconName: "checkmark.circle.fill", iconColor: .primary, counter: reminderStatsValues.completedTasks, title: "Completed")
                        }
                    }
                    
                    Text("My Lists")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    MyListView(myList: myListResaults)
                    
                    Button(action: {
                        addNewList = true
                    }, label: {
                        Text("Add List")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.headline)
                    })
                    .buttonStyle(.borderless)
                    .padding()
                }
            }
            .sheet(isPresented: $addNewList) {
                NavigationView {
                    AddNewListView { name, color in
                        do {
                            try ReminderService.saveMyList(name, color)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .onChange(of: searchingContent) { oldValue, newValue in
                isSearching = !newValue.isEmpty ? true : false
                reminderSearchResault.nsPredicate = ReminderService.getRemindersBySearchTerm(searchingContent).predicate
            }
            .onAppear {
                reminderStatsValues = reminderStatsBuilder.build(myListResaults)
            }
            .overlay(alignment: .center) {
                ReminderListView(reminders: reminderSearchResault)
                    .opacity(isSearching ? 1.0 : 0.0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationTitle("Reminders")
        }
        .searchable(text: $searchingContent, placement: .navigationBarDrawer(displayMode: .always))
    }
}

#Preview {
    MainView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
