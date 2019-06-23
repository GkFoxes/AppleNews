//
//  FavoritesCoreData.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 24/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit
import CoreData

extension FavoritesTableViewController {
    
    // MARK: - CoreData Methods
    
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
