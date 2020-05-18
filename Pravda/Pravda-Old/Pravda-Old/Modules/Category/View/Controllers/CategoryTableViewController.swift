//
//  CategoryTableViewController.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 20/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    @IBOutlet var tableCategories: UITableView!
    private let identifier = String(describing: CategoryTableViewCell.self)
    
    private var categoriesViewModel: CategoryTableViewViewModelType?
    
    static var categories: [Category] = [
        Category(id: 0, name: "News", nameAPI: "general", isChoise: true),
        Category(id: 1, name: "Business", nameAPI: "business", isChoise: false),
        Category(id: 2, name: "Entertainment", nameAPI: "entertainment", isChoise: false),
        Category(id: 3, name: "Health", nameAPI: "health", isChoise: false),
        Category(id: 4, name: "Science", nameAPI: "science", isChoise: false),
        Category(id: 5, name: "Sports", nameAPI: "sports", isChoise: false),
        Category(id: 6, name: "Technology", nameAPI: "technology", isChoise: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableCategories.tableFooterView = UIView()
        
        categoriesViewModel = CategoryViewModel(categories: CategoryTableViewController.categories)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let categoriesViewModel = categoriesViewModel else { return 0 }
        return categoriesViewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCategories.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CategoryTableViewCell
        
        guard let categoryCell = cell,  let categoriesViewModel = categoriesViewModel else { return UITableViewCell() }
        let categoryCellViewModel = categoriesViewModel.cellViewModel(forIndexPath: indexPath)
        
        categoryCell.categoriesViewModel = categoryCellViewModel
        categoryCell.accessoryType = CategoryTableViewController.categories[indexPath.row].isChoise ? .checkmark : .none
        
        return categoryCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for item in CategoryTableViewController.categories {
            if item.isChoise {
                CategoryTableViewController.categories[item.id].isChoise = false
                self.tableCategories.reloadData()
            }
        }
        tableCategories.cellForRow(at: indexPath)?.accessoryType = .checkmark
        CategoryTableViewController.categories[indexPath.row].isChoise = true
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableCategories.cellForRow(at: indexPath)?.accessoryType = .none
        CategoryTableViewController.categories[indexPath.row].isChoise = false
    }
    
    // MARK: - Button Action
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindSegueFromCategories", sender: self)
    }
}
