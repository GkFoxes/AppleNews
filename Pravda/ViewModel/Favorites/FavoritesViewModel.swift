//
//  FavoritesViewModel.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 21/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewModel: NSObject, NSFetchedResultsControllerDelegate, FavoritesTableViewViewModelType {
    
    // MARK: - Table Data
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritesTableViewCellViewModelType? {
        let article = FavoritesTableViewController.favoritesNews[indexPath.row]
        return FavoritesTableViewCellViewModel(article: article)
    }
}

extension FavoritesTableViewController {
    
    // MARK: - CoreData
    
    func initialCoreDataNews() {
        let fetchRequest: NSFetchRequest<FavoritesNews> = FavoritesNews.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "publishedAt", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            
            do {
                try fetchResultsController.performFetch()
                FavoritesTableViewController.favoritesNews = fetchResultsController.fetchedObjects!
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteCoreDataNews(atIndexPath indexPath: IndexPath) {
        FavoritesTableViewController.favoritesNews.remove(at: indexPath.row)
        //self.favoritesTableView.deleteRows(at: [indexPath], with: .fade)
        
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
}
