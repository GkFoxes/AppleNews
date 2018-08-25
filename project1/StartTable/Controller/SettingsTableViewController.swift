//
//  SettingsTableViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 25.08.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit

var cancelOrSave = false
var categories: [Category] = [
    Category(id: 0, name: "Новости", nameAPI: "", isChoise: true),
    Category(id: 1, name: "Бизнес", nameAPI: "business", isChoise: false),
    Category(id: 2, name: "Развлечения", nameAPI: "entertainment", isChoise: false),
    Category(id: 3, name: "Здоровье", nameAPI: "health", isChoise: false),
    Category(id: 4, name: "Наука", nameAPI: "science", isChoise: false),
    Category(id: 5, name: "Спорт", nameAPI: "sports", isChoise: false),
    Category(id: 6, name: "Технологии", nameAPI: "technology", isChoise: false)]

class CategoryCell : UITableViewCell {
    
    @IBOutlet var categoryLabel: UILabel!
}

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet var tableCategories: UITableView!
    
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
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCategories.dequeueReusableCell(withIdentifier: "CellCategory", for: indexPath) as! CategoryCell
        
        let object = categories[indexPath.row]
        cell.categoryLabel.text = object.name
        cell.accessoryType = object.isChoise ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for item in categories {
            if item.isChoise == true{
                categories[item.id].isChoise = false
                self.tableCategories.reloadData()
            }
        }
        tableCategories.cellForRow(at: indexPath)?.accessoryType = .checkmark
        categories[indexPath.row].isChoise = true
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableCategories.cellForRow(at: indexPath)?.accessoryType = .none
        categories[indexPath.row].isChoise = false
    }
    
    // MARK: - Button Action
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        cancelOrSave = true
        
        performSegue(withIdentifier: "unwindSegueFromSettings", sender: self)
    }
}
