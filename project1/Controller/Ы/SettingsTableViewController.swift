//
//  SettingsTableViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 25.08.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit

class CategoryCell : UITableViewCell {
    
    @IBOutlet var categoryLabel: UILabel!
}

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet var tableCategories: UITableView!
    
    let shared = SharedManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableCategories.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shared.categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCategories.dequeueReusableCell(withIdentifier: "CellCategory", for: indexPath) as! CategoryCell
        
        let object = shared.categories[indexPath.row]
        cell.categoryLabel.text = object.name
        cell.accessoryType = object.isChoise ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for item in shared.categories {
            if item.isChoise == true{
                shared.categories[item.id].isChoise = false
                self.tableCategories.reloadData()
            }
        }
        tableCategories.cellForRow(at: indexPath)?.accessoryType = .checkmark
        shared.categories[indexPath.row].isChoise = true
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableCategories.cellForRow(at: indexPath)?.accessoryType = .none
        shared.categories[indexPath.row].isChoise = false
    }
    
    // MARK: - Button Action
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        shared.cancelOrSave = true
        
        performSegue(withIdentifier: "unwindSegueFromSettings", sender: self)
    }
}
