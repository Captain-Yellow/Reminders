//
//  MyListView.swift
//  Reminders
//
//  Created by Mohammad Afshar on 10/01/2024.
//

import SwiftUI

struct MyListView: View {
    @State var pointlessViewUpdatingBool = true
    @Environment(\.colorScheme) var colorScheme
    let myList: FetchedResults<MyList>
//    var highlighted : Bool
    
    var body: some View {
        let backColor = (pointlessViewUpdatingBool || !pointlessViewUpdatingBool) /*&& highlighted*/ ? Color.blue : Color( UIColor.systemGroupedBackground)
        
        if myList.isEmpty {
            ContentUnavailableView("No Item", image: "xmark.circle")
        } else {
            // List {
            ForEach(myList) { list in
                NavigationLink(value: list) {
                    MyListCellView(list: list)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                        .font(.title3)
                        .foregroundStyle(colorScheme == .dark ? Color.offWhite : Color.darkGray)
                }
                Divider()
            }
            .onAppear{
                        pointlessViewUpdatingBool.toggle()
                    }
            .contentShape(Rectangle())
            .listRowBackground(colorScheme == .dark ? Color.darkGray : Color.offWhite)
//            .listRowBackground(backColor)
            // }
            .scrollContentBackground(.hidden)
            .navigationDestination(for: MyList.self) { list in
                MyListDetailView(myList: list)
                    .navigationTitle(list.name)
            }
        }
    }
}

//#Preview {
//    MyListView()
//}
