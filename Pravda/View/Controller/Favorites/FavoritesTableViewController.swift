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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesViewModel = FavoritesViewModel()
        guard let favoritesViewModel = favoritesViewModel else { return }
        favoritesViewModel.initialCoreDataNews()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let favoritesViewModel = favoritesViewModel else { return 0 }
        return favoritesViewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FavoritesTableViewCell
        
        guard let favoritesCell = cell, let favoritesViewModel = favoritesViewModel else { return UITableViewCell() }
        
        let favoritesCellViewModel = favoritesViewModel.cellViewModel(forIndexPath: indexPath)
        
        favoritesCell.favoritesViewModel = favoritesCellViewModel
        
        return favoritesCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let link = FavoritesViewModel.favoritesNews[indexPath.row].url else { return }
        
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
            
            guard let favoritesViewModel = self.favoritesViewModel else { return }
            favoritesViewModel.deleteCoreDataNews(atIndexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
        
        FavoritesViewModel.favoritesNews = controller.fetchedObjects as! [FavoritesNews]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
