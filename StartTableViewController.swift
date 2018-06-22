//
//  StartTableViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 16.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//
import UIKit

class StartTableViewController: UITableViewController {
    
    @IBOutlet weak var tableContent: UITableView!
    @IBAction func close(segue: UIStoryboardSegue) {
        //Cancels the addition new element in CoreData
    }
    
    var detailViewController: StartDetailViewController? = nil
    var actresses: [Girl] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actresses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StartTableViewCell
        
        cell.nameLabel.text = actresses[indexPath.row].name!
        return cell
    }
    
    // MARK: - Delete and share from table
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let share = UITableViewRowAction(style: .default, title: "Поделиться") { (action, indexPath) in
            
            let defaultText = "Цифра " + self.actresses[indexPath.row].name!
            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        }
        
        let delete = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
            
            self.actresses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                //let objectToDelete = self.fetchResultsController.object(at: indexPath)
                //context.delete(objectToDelete)
                
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        share.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return [delete]
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let actresses = self.actresses[indexPath.row]
                let destinationViewController = (segue.destination as! UINavigationController).topViewController as! StartDetailViewController
                destinationViewController.girlsName = actresses.name!
                destinationViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                destinationViewController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
