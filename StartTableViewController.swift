//
//  StartTableViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 16.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//
import UIKit
import CoreData

class StartTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableContent: UITableView!
    @IBAction func close(segue: UIStoryboardSegue) {
        //Cancels the addition new element in CoreData
    }
    
    var detailViewController: StartDetailViewController? = nil
    
    var selectedGirl: Girl!
    
    var context: NSManagedObjectContext!
    var fetchResultsController: NSFetchedResultsController<Girl>!
    var actresses: [Girl] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
                getDataFromFile()
        
                let fetchRequest: NSFetchRequest<Girl> = Girl.fetchRequest()
                //let name = tableView.ind
                //fetchRequest.predicate = NSPredicate(format: "name == %@", name!)
        
                do {
                    let results = try context.fetch(fetchRequest)
                    selectedGirl = results[0]
                    insertDataFrom(selectedGirl: selectedGirl)
                } catch {
                    print(error.localizedDescription)
                }
        
        let fetchedRequest: NSFetchRequest<Girl> = Girl.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchedRequest.sortDescriptors = [sortDescriptor]
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            
            do {
                try fetchResultsController.performFetch()
                actresses = fetchResultsController.fetchedObjects!
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
        func insertDataFrom(selectedGirl: Girl) {
            tableView.insertRows(at: 0, with: .fade)
        }
    
        func getDataFromFile() {
            let fetchRequest: NSFetchRequest<Girl> = Girl.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name != nil") //xz
    
            var records = 0
    
            do {
                let count = try context.count(for: fetchRequest)
                records = count
                print("Data is there already?")
            } catch {
                print(error.localizedDescription)
            }
    
            guard  records == 0 else { return }
            let pathToFile = Bundle.main.path(forResource: "data", ofType: "plist")
            let dataArray = NSArray(contentsOfFile: "pathToFile")!
    
            for dictionary in dataArray {
                let entity = NSEntityDescription.entity(forEntityName: "Girl", in: context)
                let girl = NSManagedObject(entity: entity!, insertInto: context) as! Girl
    
                let girlsDictionary = dictionary as! NSDictionary
                girl.name = girlsDictionary["name"] as? String
            }
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
                
                let objectToDelete = self.fetchResultsController.object(at: indexPath)
                context.delete(objectToDelete)
                
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
