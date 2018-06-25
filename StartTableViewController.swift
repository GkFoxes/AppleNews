//
//  StartTableViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 16.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//
import UIKit
import RealmSwift

class StartTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tableContent: UITableView!
    @IBAction func close(segue: UIStoryboardSegue) {
        //Cancels the addition new element in CoreData
    }
    
    var detailViewController: StartDetailViewController? = nil
    
    var girlsList: Results<Girl>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? StartDetailViewController
        }
        
        realm = try! Realm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        girlsList = realm.objects(Girl.self)
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
        return girlsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StartTableViewCell
        
        let item = girlsList[indexPath.row]
        cell.nameLabel.text = item.name
        return cell
    }
    
    // MARK: - Delete and edit from table
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            let item = self.girlsList[indexPath.row]
            try! realm.write({
                realm.delete(item)
            })
            tableView.deleteRows(at:[indexPath], with: .automatic)
        }
        
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            let girlToBeUpdated = self.girlsList[indexPath.row]
            self.performSegue(withIdentifier: "editDetail", sender: girlToBeUpdated)
        }
        
        edit.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return [delete, edit]
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let name = girlsList[indexPath.row].name
                let biography = girlsList[indexPath.row].biography
                let link = girlsList[indexPath.row].link
                
                let destinationViewController = (segue.destination as! UINavigationController).topViewController as! StartDetailViewController
                destinationViewController.girlName = name
                destinationViewController.girlBiography = biography
                destinationViewController.girlLink = link
                
                destinationViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                destinationViewController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
//    func prepare(for segue: UIStoryboardSegue, sender: girlToBeUpdated) {
//        if segue.identifier == "editDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let editName = girlsList[indexPath.row].name
//                let editBiography = girlsList[indexPath.row].biography
//                let editLink = girlsList[indexPath.row].link
//                
//                let destinationEditViewController = (segue.destination as! UINavigationController).topViewController as! EditDetailTableViewController
//                destinationEditViewController.editNameTextField.text = editName
//                destinationEditViewController.editBiographyTextField.text = editBiography
//                destinationEditViewController.editlinkTextField.text = editLink
//                
//                destinationEditViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//                destinationEditViewController.navigationItem.leftItemsSupplementBackButton = true
//            }
//        }
//    }
}

