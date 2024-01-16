//
//  ReminderStatsView.swift
//  Reminders
//
//  Created by Mohammad Afshar on 15/01/2024.
//

import SwiftUI

struct ReminderStatsView: View {
    let iconName: String
    let iconColor: Color
    let counter: Int
    let title: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
//        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: iconName)
                        .foregroundStyle(iconColor)
                        .font(.title)

                    Text(title)
                        .opacity(0.8)
                        .foregroundStyle(colorScheme == .dark ? Color.offWhite : Color.darkGray)
                }
                
                Spacer()
                
                Text(counter, format: .number)
                    .font(.largeTitle)
                    .foregroundStyle(colorScheme == .dark ? Color.offWhite : Color.darkGray)
            }
//        }
        .padding()
        .background(colorScheme == .dark ? Color.darkGray : Color.offWhite)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

//#Preview {
//    ReminderStatsView()
//        .environment(\.colorScheme, .dark)
//}
