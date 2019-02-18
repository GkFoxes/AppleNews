//
//  MasterViewController.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 04/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {

    var detailViewController: NewsDetailViewController? = nil
    
    var newsViewModel: NewsTableViewViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? NewsDetailViewController
        }
        
        newsViewModel = NewsViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            //if let indexPath = tableView.indexPathForSelectedRow {
                
                let destinationViewController = (segue.destination as! UINavigationController).topViewController as! NewsDetailViewController
                
                destinationViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                destinationViewController.navigationItem.leftItemsSupplementBackButton = true
            //}
        }
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel?.numberOfRows() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell
        
        guard let newsCell = cell, let newsViewModel = newsViewModel else { return UITableViewCell() }
        
        let newsCellViewModel = newsViewModel.cellViewModel(forIndexPath: indexPath)
        
        newsCell.newsViewModel = newsCellViewModel
        
        return newsCell
    }
}
