//
//  ColorPickerView.swift
//  Reminders
//
//  Created by Mohammad Afshar on 10/01/2024.
//

import SwiftUI

struct ColorPickerView: View {
    let colors: [Color] = [.yellow, .orange, .pink, .red, .purple, .green, .blue]
    @Binding var selectedColor: Color
    
    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
                ZStack {
                    Circle()
                        .fill()
                        .foregroundStyle(color)
                    Circle()
                        .strokeBorder(selectedColor == color ? .black : .clear, lineWidth: 3)
                        .scaleEffect(CGSize(width: 1.2, height: 1.2))
                }
                .onTapGesture {
                    selectedColor = color
                }
                //                        .overlay {
                //                            if selectedColor == color {
                //                                Circle()
                //                                    .strokeBorder(selectedColor == color ? .black : .clear, lineWidth: 3)
                //                                    .scaleEffect(CGSize(width: 1.2, height: 1.2))
                //                            }
                //                        }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 100)
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
    }
}

#Preview {
    ColorPickerView(selectedColor: .constant(.red))
}
