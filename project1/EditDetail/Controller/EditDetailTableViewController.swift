//
//  EditDetailTableViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 25.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit

class EditDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var editNameTextField: UITextField!
    @IBOutlet weak var editBiographyTextField: UITextField!
    @IBOutlet weak var editlinkTextField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if ((editNameTextField.text?.isEmpty)! || editNameTextField.text == " ") || ((editBiographyTextField.text?.isEmpty)! || editBiographyTextField.text == " ") {
            print ("Не все поля заполнены!")
        } else {
            
            let girlItem = Girl()
            girlItem.name = editNameTextField.text!
            girlItem.biography = editBiographyTextField.text!
            
            try! realm.write({
                realm.add(girlItem)
            })
        }
        performSegue(withIdentifier: "unwindEditSegueFromNewCell", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //editNameTextField = editName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
