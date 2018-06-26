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
        if ((editNameTextField.text?.isEmpty)! || editNameTextField.text == " ") || ((editBiographyTextField.text?.isEmpty)! || editBiographyTextField.text == " ") || ((editlinkTextField.text?.isEmpty)! || editlinkTextField.text == " ") {
            let alert = UIAlertController(title: "Can not save", message: "You did not fill all the fields, please check again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let girlItem = Girl()
            girlItem.name = editNameTextField.text!
            girlItem.biography = editBiographyTextField.text!
            girlItem.link = editlinkTextField.text!
            
            try! realm.write({
                realm.add(girlItem, update: false)
            })
            
            try! realm.write({
                realm.delete(girlToDelete)
            })
            performSegue(withIdentifier: "unwindEditSegueFromNewCell", sender: self)
        }
    }
    
    var editDetailName = "name"
    var editDetailBiography = "bio"
    var editDetailLink = "link"
    
    var girlToDelete = Girl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editNameTextField.text = editDetailName
        editBiographyTextField.text = editDetailBiography
        editlinkTextField.text = editDetailLink
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
