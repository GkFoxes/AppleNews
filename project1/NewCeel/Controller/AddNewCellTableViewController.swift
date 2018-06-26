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
    @IBOutlet weak var biographyTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if ((nameTextField.text?.isEmpty)! || nameTextField.text == " ") || ((biographyTextField.text?.isEmpty)! || biographyTextField.text == " ") || ((linkTextField.text?.isEmpty)! || linkTextField.text == " ") {
            let alert = UIAlertController(title: "Can not save", message: "You did not fill all the fields, please check again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let girlItem = Girl()
            girlItem.name = nameTextField.text!
            girlItem.biography = biographyTextField.text!
            girlItem.link = linkTextField.text!
            
            try! realm.write({
                realm.add(girlItem)
            })
            performSegue(withIdentifier: "unwindSegueFromNewCell", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

