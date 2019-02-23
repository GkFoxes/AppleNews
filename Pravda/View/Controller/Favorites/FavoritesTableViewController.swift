//
//  FavoritesTableViewController.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 21/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit
import CoreData
import SafariServices

class FavoritesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet var favoritesTableView: UITableView!
    private let identifier = String(describing: FavoritesTableViewCell.self)
    
    private var favoritesViewModel: FavoritesTableViewViewModelType?
    var context: NSManagedObjectContext!
    var fetchResultsController: NSFetchedResultsController<FavoritesNews>!
    
    var favoritesNews: [FavoritesNews] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesViewModel = FavoritesViewModel()
        //guard let favoritesViewModel = favoritesViewModel else { return }
        //favoritesViewModel.initialCoreDataNews()
        let fetchRequest: NSFetchRequest<FavoritesNews> = FavoritesNews.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "publishedAt", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            
            do {
                try fetchResultsController.performFetch()
                favoritesNews = fetchResultsController.fetchedObjects!
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesNews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FavoritesTableViewCell
        
        guard let favoritesCell = cell, let favoritesViewModel = favoritesViewModel else { return UITableViewCell() }
        
        let favoritesCellViewModel = favoritesViewModel.cellViewModel(forIndexPath: indexPath)
        
        favoritesCell.favoritesViewModel = favoritesCellViewModel
        
        return favoritesCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let link = favoritesNews[indexPath.row].url else { return }
        
        if let url = URL(string: link) {
            if  UIApplication.shared.canOpenURL(url) {
                let svc = SFSafariViewController(url: url)
                self.present(svc, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Can not open this website", message: "Please check the existence of the website", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            
            //guard let favoritesViewModel = self.favoritesViewModel else { return }
            //favoritesViewModel.deleteCoreDataNews(atIndexPath: indexPath)
            //tableView.deleteRows(at: [indexPath], with: .fade)
            
            //guard var favoritesNews = self.favoritesNews else { return }
            self.favoritesNews.remove(at: indexPath.row)
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
        
        delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return [delete]
    }
    
    // MARK: - Fetch results controller delegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case.insert:
            guard let indexPath = newIndexPath else { break }
            tableView.insertRows(at: [indexPath], with: .fade)
        case .delete:
            guard let indexPath = indexPath else { break }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update:
            guard let indexPath = indexPath else { break }
            tableView.reloadRows(at: [indexPath], with: .fade)
        default:
            tableView.reloadData()
        }
        
        //guard let favoritesNews = FavoritesViewModel.favoritesNewselse { return }
        favoritesNews = controller.fetchedObjects as! [FavoritesNews]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
