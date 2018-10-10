//
//  StartTableViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 16.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//
import UIKit

class StartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class StartTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tableContent: UITableView!
    
    var detailViewController: StartDetailViewController? = nil
    
    let shared = SharedManager.shared
    
    var refresher: UIRefreshControl!
    
    var articlesToNews: [DataAPI]? = nil
    var news: News? = nil
    var totalInPage: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? StartDetailViewController
        }
        
        refresher = UIRefreshControl()
        refresher.tintColor = UIColor.white
        refresher.addTarget(self, action: #selector(StartTableViewController.populate), for: UIControlEvents.valueChanged)
        tableContent.refreshControl = refresher
        
        getInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
        self.tableContent.setEditing(false, animated: true)
        self.tableContent.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableContent.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if news != nil {
            return news!.articles!.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StartTableViewCell
        
        guard news != nil else { return cell }
        
        let item = news!.articles![indexPath.row]
        cell.nameLabel.text = item.title
        cell.authorLabel.text = item.source?.name
        
        let dateString = item.publishedAt
        let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let newFormat = DateFormatter()
        newFormat.dateFormat = "HH:mm"
        newFormat.locale = Locale(identifier: "ru_RU")
        
        if dateString != nil {
            if let date = dateFormatter.date(from: dateString!) {
                cell.dateLabel.text = newFormat.string(from: date)
            }
        } else {
            cell.dateLabel.text = ""
        }
        
        if indexPath.row == news!.articles!.count - 5 {
            guard totalInPage != nil else { return cell }
            
            if news!.articles!.count < totalInPage! {
                shared.pageSearch += 1
                loadDataFromNextPage()
            }
        }
        
        return cell
    }
    
    // MARK: - Button Action
    
    @IBAction func close(segue: UIStoryboardSegue) {
        if shared.cancelOrSave {
            shared.pageSearch = 1
            for item in shared.categories {
                if (item.id != 0) && (item.isChoise == true) {
                    self.title = item.name
                    break
                } else {
                    self.title = "Новости"
                }
            }
            
            getInitialData()
            
            tableContent.reloadData()
        }
        shared.cancelOrSave = false
        tableContent.reloadData()
    }
    
    @objc func populate() {
        getInitialData()
        refresher.endRefreshing()
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                guard news != nil else { return }
                
                guard let details = news!.articles else { return }
                let nameDetail = details[indexPath.row].source?.name
                let title = details[indexPath.row].title
                let descriptionDetal = details[indexPath.row].description
                let linkDetail = details[indexPath.row].url
                let photoDetailURL = details[indexPath.row].urlToImage
                let sourceDetail = details[indexPath.row].source
                let authorDetail = details[indexPath.row].author
                let publishedAtDetail = details[indexPath.row].publishedAt
                
                let destinationViewController = (segue.destination as! UINavigationController).topViewController as! StartDetailViewController
                destinationViewController.title = nameDetail
                
                if title != nil {
                    destinationViewController.titleDetail = title!
                }
                if descriptionDetal != nil {
                    destinationViewController.descriptionText = descriptionDetal!
                }
                if linkDetail != nil {
                    destinationViewController.link = linkDetail!
                }
                if photoDetailURL != nil {
                    destinationViewController.photoString = photoDetailURL!
                }
                
                if sourceDetail?.name != nil {
                    destinationViewController.sourceRealm = sourceDetail!.name!
                }
                
                if authorDetail != nil {
                    destinationViewController.authorRealm = authorDetail!
                }
                
                if publishedAtDetail != nil {
                    destinationViewController.publishedAtRealm = publishedAtDetail!
                }
            
                destinationViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                destinationViewController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
