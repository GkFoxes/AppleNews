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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableCategories.tableFooterView = UIView()
        
        categoriesViewModel = CategoryViewModel()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesViewModel?.numberOfRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCategories.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CategoryTableViewCell
        
        guard let categoryCell = cell, let categoriesViewModel = categoriesViewModel else { return UITableViewCell() }
        let categoryCellViewModel = categoriesViewModel.cellViewModel(forIndexPath: indexPath)
        
        categoryCell.categoriesViewModel = categoryCellViewModel
        
        return categoryCell
    }
    // MARK: - Button Action
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindSegueFromCategories", sender: self)
    }
}
