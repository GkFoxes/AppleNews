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

class FavoritesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, SwipeTableViewCellDelegate {
    
    @IBOutlet var favoritesTableView: UITableView!
    private let identifier = String(describing: FavoritesTableViewCell.self)
    
    private var favoritesViewModel: FavoritesTableViewViewModelType?
    
    var context: NSManagedObjectContext!
    var fetchResultsController: NSFetchedResultsController<FavoritesNews>!
    static var favoritesNews: [FavoritesNews] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesViewModel = FavoritesViewModel()
        initialCoreDataNews()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoritesTableViewController.favoritesNews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FavoritesTableViewCell
        
        guard let favoritesCell = cell, let favoritesViewModel = favoritesViewModel else { return UITableViewCell() }
        favoritesCell.delegate = self
        
        let favoritesCellViewModel = favoritesViewModel.cellViewModel(forIndexPath: indexPath)
        favoritesCell.favoritesViewModel = favoritesCellViewModel
        
        return favoritesCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let link = FavoritesTableViewController.favoritesNews[indexPath.row].url else { return }
        
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "") { action, indexPath in
            self.deleteCoreDataNews(atIndexPath: indexPath)
        }
        
        deleteAction.backgroundColor = .white
        deleteAction.image = UIImage(named: "deleteCell")
        
        return [deleteAction]
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
        
        FavoritesTableViewController.favoritesNews = controller.fetchedObjects as! [FavoritesNews]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // MARK: - Button Action
    
    @IBAction func close(segue: UIStoryboardSegue) {
        //Work when dismiss Reminder View
    }
}
