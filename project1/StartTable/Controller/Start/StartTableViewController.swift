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
        tableContent.reloadData()
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
        fetchCurrentWeatherData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
        girlsList = realm.objects(Girl.self)
        self.girlsList = self.girlsList.sorted(byKeyPath: "createdAt", ascending:false)
        
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
            
            if self.splitViewController?.viewControllers.count == 2 {
                self.performSegue(withIdentifier: "detailSegue", sender: self)
            }
            
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
                destinationViewController.title = name
                destinationViewController.girlBiography = biography
                destinationViewController.girlLink = link
                
                destinationViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                destinationViewController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        
        if segue.identifier == "editDetail" {
            let destinationEditViewController = (segue.destination as! UINavigationController).topViewController as! EditDetailTableViewController
            
            let object = sender as! Girl
            
            let editName = object.name
            let editBiography = object.biography
            let editLink = object.link
            
            destinationEditViewController.editDetailName = editName
            destinationEditViewController.editDetailBiography = editBiography
            destinationEditViewController.editDetailLink = editLink
            destinationEditViewController.girlToDelete = object
        }
    }
    
    // MARK: - This Data for Weather API
    
    lazy var weatherManager = APIWeatherManager(apiKey: "416e4d01fc649f94c5c4b5c68ec20ed6")
    
    let coordinates = [
        Coordinates(latitude: 59.939095, longitude: 30.315868, name: "St. Petersburg"),
        Coordinates(latitude: 55.755814, longitude: 37.617635, name: "Moscow"),
        Coordinates(latitude: 54.707390, longitude: 20.507307, name: "Kaliningrad"),
        Coordinates(latitude: 53.195063, longitude: 45.018316, name: "Penza"),
        Coordinates(latitude: 55.030199, longitude: 82.920430, name: "Novosibirsk"),
        Coordinates(latitude: 55.796289, longitude: 49.108795, name: "Kazan"),
        Coordinates(latitude: 58.522810, longitude: 31.269915, name: "Veliky Novgorod"),
        Coordinates(latitude: 56.326887, longitude: 44.005986, name: "Nizhny Novgorod"),
        Coordinates(latitude: 54.989342, longitude: 73.368212, name: "Omsk"),
        Coordinates(latitude: 53.195538, longitude: 50.101783, name: "Samara")
    ]
}
