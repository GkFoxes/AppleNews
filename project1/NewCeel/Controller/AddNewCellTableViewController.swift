//
//  NewCellTableViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 18.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit

class AddNewCellTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if ((nameTextField.text?.isEmpty)! || nameTextField.text == " ") {
            print ("Не все поля заполнены!")
        } else {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let girls = Girl(context: context)
                girls.name = nameTextField.text
                
                do {
                    try context.save()
                    print("Сохранение удалось")
                } catch let error as NSError{
                    print("Не удалось сохранить данные \(error.userInfo)!")
                }
            }
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

