//
//  StartTableViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 16.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//
import UIKit
import RealmSwift

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
        
        realm = try! Realm()
        
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
        cell.authorLabel.text = item.author
        cell.dateLabel.text = item.publishedAt
        return cell
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                //let name = girlsList[indexPath.row].name
                //let biography = girlsList[indexPath.row].biography
                //let link = girlsList[indexPath.row].link
                
                let destinationViewController = (segue.destination as! UINavigationController).topViewController as! StartDetailViewController
                //destinationViewController.title = name
                //destinationViewController.girlBiography = biography
                //destinationViewController.girlLink = link
                
                destinationViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                destinationViewController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
