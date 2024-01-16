//
//  SelectListView.swift
//  Reminders
//
//  Created by Mohammad Afshar on 13/01/2024.
//

import SwiftUI

struct SelectListView: View {
    @FetchRequest(sortDescriptors: [])
    private var myList: FetchedResults<MyList>
    
    @Binding var selectList: MyList?
    
    var body: some View {
        List(myList) { list in
            HStack {
                HStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundStyle(Color(uiColor: list.color))
                    Text(list.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectList = list
                }
                
                Spacer()
                
                if selectList == list {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    SelectListView(selectList: .constant(PreviewData.myList))
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
