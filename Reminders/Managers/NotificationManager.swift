//
//  NotificationManager.swift
//  Reminders
//
//  Created by Mohammad Afshar on 16/01/2024.
//

import Foundation
import UserNotifications
import WidgetKit
import UIKit

struct UserNotification {
    let title: String?
    let note: String?
    let date: Date?
    let time: Date?
}

class NotificationManager {
    static func scheduleNotification(userNotification: UserNotification) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = userNotification.title ?? "Notification"
        notificationContent.body = userNotification.note ?? "You have a Notification!"
        notificationContent.sound = UNNotificationSound.default
        
        var dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: userNotification.date ?? Date())
        print("\n\n<-- notification date \(userNotification.date)")
        print("ndate component \(dateComponent)")
        
        if let reminderTime = userNotification.time {
            let reminderTimeDateComponent = reminderTime.dateComponents
            print("\nnotification time \(reminderTime)")
            print("time component \(reminderTimeDateComponent)-->\n\n")
            dateComponent.hour = reminderTimeDateComponent.hour
            dateComponent.minute = reminderTimeDateComponent.minute
        }
        
        // Add the image attachment
            if let imageURL = Bundle.main.url(forResource: "test", withExtension: "jpg") {
                print("\n\nresource OK")
                do {
                    let attachment = try UNNotificationAttachment(identifier: "imageAttachment", url: imageURL, options: nil)
                    notificationContent.attachments = [attachment]
                } catch {
                    print("Error creating image attachment: \(error)")
                }
            } else {
                print("\n\nresource NOOK")
            }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let notificationRequest = UNNotificationRequest(identifier: "ReminderNotification", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(notificationRequest)
    }
        
    
    static func asaskingForPermissionk() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                
            } else {
                
            }
            
            if let error = error as NSError?, error.code == 3000 {
                // The user has denied permission, prompt them to enable it in settings
                print("permission denied \(error)")
                openAppSettings()
                //                showPermissionDeniedAlert()
            }
        }
    }
    
    static func showPermissionDeniedAlert() {
        
    }
    
    static func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        
        // Check if the URL can be opened before attempting to open it
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
}
