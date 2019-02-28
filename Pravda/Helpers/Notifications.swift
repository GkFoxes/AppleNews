//
//  Notifications.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 26/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAutorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
        }
    }
    
    func scheduleNotification(forNotifaicationBody notificationBody: String, withTimeInterval timeInterval: TimeInterval) {
        
        let content = UNMutableNotificationContent()
        let userAction = "User Reminder"
        
        content.title = "Read your favorite news"
        content.body = notificationBody
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userAction
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let identifire = "Local Notification"
        let request = UNNotificationRequest(identifier: identifire,
                                            content: content,
                                            trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        let reminderAction = UNNotificationAction(identifier: "ReminderAction", title: "Remind in 15 minutes", options: [])
        let category = UNNotificationCategory(
            identifier: userAction,
            actions: [reminderAction],
            intentIdentifiers: [],
            options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notification with the Local Notification Identifire")
        }
        
        switch response.actionIdentifier {
        case "ReminderAction":
            print("Snooze")
            scheduleNotification(forNotifaicationBody: "We remind again", withTimeInterval: 15 * 60)
        default:
            print("Unknown action")
        }
        
        completionHandler()
    }
}
