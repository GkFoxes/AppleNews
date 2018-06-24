//
//  NewCellTableViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 18.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewCellTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if ((nameTextField.text?.isEmpty)! || nameTextField.text == " ") {
            print ("Не все поля заполнены!")
        } else {
            let girlItem = Girl()
            girlItem.name = nameTextField.text!
            
            // We are adding the reminder to our database
            try! realm.write({
                realm.add(girlItem)
            })
            
        }
        performSegue(withIdentifier: "unwindSegueFromNewCell", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

