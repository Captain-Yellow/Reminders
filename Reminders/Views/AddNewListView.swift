//
//  AddNewListView.swift
//  Reminders
//
//  Created by Mohammad Afshar on 10/01/2024.
//

import SwiftUI

struct AddNewListView: View {
    @Environment(\.dismiss) private var dismiss
    @State var name: String = ""
    @State var selectedColor: Color = .yellow
    let onSave: (String ,UIColor) -> Void
    
    private var isFormValid: Bool {
        name.isEmpty
    }
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "line.3.horizontal.circle.fill")
                    .foregroundStyle(selectedColor)
                    .font(.system(size: 100))
                    .clipShape(Circle())
                
                TextField("List Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
            }
            .padding(30)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        
            ColorPickerView(selectedColor: $selectedColor)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("New List")
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    onSave(name, UIColor(selectedColor))
                    dismiss()
                }
                .disabled(isFormValid)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
        }
        
    }
}

#Preview {
    NavigationStack {
        AddNewListView(onSave: { _, _ in })
    }
}
