//
//  FavoritesReminderViewController.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 26/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit
import UserNotifications

class FavoritesReminderViewController: UIViewController {
    
    @IBOutlet weak var reminderDatePicker: UIDatePicker!
    @IBOutlet weak var reminderTextField: UITextField!
    
    let notifications = Notifications()
    var isAutorization = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminderDatePicker.countDownDuration = 60
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            self.isAutorization = granted
        }
    }
    
    // MARK: - Button Action
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if isAutorization {
            let notificationBody: String
            if self.reminderTextField.text != "" {
                notificationBody = self.reminderTextField.text!
            } else {
                notificationBody = "News does not read itself"
            }
            
            let timeInterval = self.reminderDatePicker.countDownDuration
            
            self.notifications.scheduleNotification(forNotifaicationBody: notificationBody, withTimeInterval: timeInterval)
            performSegue(withIdentifier: "unwindSegueFromReminder", sender: self)
        } else {
            let alert = UIAlertController(title: "Notifications disabled",
                                          message: "Please open the Settings application and enable the Notification.",
                                          preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                self.performSegue(withIdentifier: "unwindSegueFromReminder", sender: self)
            }
            
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
