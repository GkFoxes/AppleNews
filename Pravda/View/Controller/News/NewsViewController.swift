//
//  MasterViewController.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 04/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    private let identifier = String(describing: NewsTableViewCell.self)
    
    var detailViewController: NewsDetailViewController? = nil
    
    private var newsViewModel: NewsTableViewViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? NewsDetailViewController
        }
        newsTableView.tableFooterView = UIView()
        
        newsViewModel = NewsViewModel()
        
        guard let newsViewModel = newsViewModel else { return }
        newsViewModel.setSpinner(forTable: newsTableView)
        setInitialData()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    // MARK: - Methods
    
    func setInitialData() {
        guard let newsViewModel = newsViewModel else { return }
        newsViewModel.getInitialData {
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
                self.newsViewModel?.removeSpinner()
                
                if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.newsTableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
                    self.performSegue(withIdentifier: "showNewsDetail", sender: indexPath)
                }
            }
        }
    }
    
    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel?.numberOfRows() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? NewsTableViewCell
        
        guard let newsCell = cell, let newsViewModel = newsViewModel else { return UITableViewCell() }
        let newsCellViewModel = newsViewModel.cellViewModel(forIndexPath: indexPath)
        
        newsCell.newsViewModel = newsCellViewModel
        
        if indexPath.row == newsViewModel.numberOfRows() - 3 {
            newsViewModel.loadNextPage() {
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            }
        }

        return newsCell
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNewsDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let newsViewModel = newsViewModel else { return }
                newsViewModel.selectRow(atIndexPath: indexPath)
                
                if let destinationViewController = (segue.destination as! UINavigationController).topViewController as? NewsDetailViewController {
                    destinationViewController.detailViewModel = newsViewModel.viewModelForSelectedRow()
                    destinationViewController.title = newsViewModel.viewModelForSelectedRow()?.author
                    
                    destinationViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                    destinationViewController.navigationItem.leftItemsSupplementBackButton = true
                }
            }
        }
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        guard let newsViewModel = newsViewModel else { return }
        let category = newsViewModel.chooseCategory()
        self.title = category.name
        
        setInitialData()
    }
}
