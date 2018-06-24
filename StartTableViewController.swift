//
//  StartTableViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 16.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//
import UIKit
import RealmSwift

class StartTableViewController: UITableViewController {
    
    @IBOutlet weak var tableContent: UITableView!
    @IBAction func close(segue: UIStoryboardSegue) {
        //Cancels the addition new element in CoreData
    }
    
    var detailViewController: StartDetailViewController? = nil

    func readAndUpdateUI(){
        girlsList = realm.objects(Girl.self)
        tableContent.setEditing(false, animated: true)
        tableContent.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? StartDetailViewController
        }
        
        realm = try! Realm()
        if realm.isEmpty {
            girlInitial()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        readAndUpdateUI()
    }
    
    override func viewDidAppear (_ animated: Bool ) {
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
        return girlsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StartTableViewCell
        
        let item = girlsList[indexPath.row]
        cell.nameLabel.text = item.name
        return cell
    }
    
    // MARK: - Delete and share from table
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            let item = girlsList[indexPath.row]
            try! realm.write({
                realm.delete(item)
            })
            tableView.deleteRows(at:[indexPath], with: .automatic)
        }
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let girl = girlsList[indexPath.row].name
                let destinationViewController = (segue.destination as! UINavigationController).topViewController as! StartDetailViewController
                destinationViewController.girlName = girl
                destinationViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                destinationViewController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
