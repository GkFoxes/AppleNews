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
    
    private var categoriesViewModel: CategoryTableViewViewModelType = CategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableCategories.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesViewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCategories.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CategoryTableViewCell
        
        guard let categoryCell = cell else { return UITableViewCell() }
        let categoryCellViewModel = categoriesViewModel.cellViewModel(forIndexPath: indexPath)
        
        categoryCell.categoriesViewModel = categoryCellViewModel
        categoryCell.accessoryType = categoriesViewModel.categories[indexPath.row].isChoise ? .checkmark : .none
        
        return categoryCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoriesViewModel.setCategory() {
            self.tableCategories.reloadData()
        }
        tableCategories.cellForRow(at: indexPath)?.accessoryType = .checkmark
        categoriesViewModel.chooseCategory(forIndexPath: indexPath, isSet: true)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableCategories.cellForRow(at: indexPath)?.accessoryType = .none
        categoriesViewModel.chooseCategory(forIndexPath: indexPath, isSet: false)
    }
    
    // MARK: - Button Action
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindSegueFromCategories", sender: self)
    }
}
