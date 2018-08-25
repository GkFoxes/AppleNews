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
    
    @IBAction func close(segue: UIStoryboardSegue) {
        tableContent.reloadData()
    }
    
    var detailViewController: StartDetailViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? StartDetailViewController
        }
        
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
        return news.articles!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StartTableViewCell
        
        let item = news.articles![indexPath.row]
        cell.nameLabel.text = item.title
        cell.authorLabel.text = item.source?.name
        
        let dateString = item.publishedAt
        let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let newFormat = DateFormatter()
        newFormat.dateFormat = "MM.dd HH:mm"
        newFormat.locale = Locale(identifier: "ru_RU")
        
        if dateString != nil {
            if let date = dateFormatter.date(from: dateString!) {
                cell.dateLabel.text = newFormat.string(from: date)
            }
        } else {
            cell.dateLabel.text = ""
        }
        
        if indexPath.row == news.articles!.count - 5 {
            if news.articles!.count < totalInPage! {
                pageSearch += 1
                loadDataFromNextPage()
            }
        }
        
        return cell
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                guard let details = news.articles else { return }
                let nameDetail = details[indexPath.row].source?.name
                let title = details[indexPath.row].title
                let descriptionDetal = details[indexPath.row].description
                let linkDetail = details[indexPath.row].url
                let photoDetailURL = details[indexPath.row].urlToImage
                
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
                
                destinationViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                destinationViewController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
