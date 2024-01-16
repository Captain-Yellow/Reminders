//
//  MyListCellView.swift
//  Reminders
//
//  Created by Mohammad Afshar on 10/01/2024.
//

import SwiftUI

struct MyListCellView: View {
    let list: MyList
    
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .foregroundStyle(Color(uiColor: list.color))
            
            Text(list.name)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
                .opacity(0.4)
                .padding(.trailing, 10)
        }
    }
}

#Preview {
    MyListCellView(list: PreviewData.myList)
}
