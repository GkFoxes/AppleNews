//
//  FavoritesReminderViewController.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 26/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class FavoritesReminderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Button Action
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
       performSegue(withIdentifier: "unwindSegueFromReminder", sender: self)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueFromReminder", sender: self)
    }
}
