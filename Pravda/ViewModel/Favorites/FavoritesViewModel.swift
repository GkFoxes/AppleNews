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
    
    static var favoritesNews: [FavoritesNews]?
    
    var context: NSManagedObjectContext!
    var fetchResultsController: NSFetchedResultsController<FavoritesNews>!
    
    // MARK: - Table Data
    
    func numberOfRows() -> Int {
        guard let favoritesNews = FavoritesViewModel.favoritesNews else { return 0 }
        return favoritesNews.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritesTableViewCellViewModelType? {
        guard let favoritesNews = FavoritesViewModel.favoritesNews else { return nil }
        let article = favoritesNews[indexPath.row]
        return FavoritesTableViewCellViewModel(article: article)
    }
    
    // MARK: - CoreData
    
    func initialCoreDataNews() {
        let fetchRequest: NSFetchRequest<FavoritesNews> = FavoritesNews.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "publishedAt", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            
            do {
                try fetchResultsController.performFetch()
                FavoritesViewModel.favoritesNews = fetchResultsController.fetchedObjects!
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteCoreDataNews(atIndexPath indexPath: IndexPath) {
        guard var favoritesNews = FavoritesViewModel.favoritesNews else { return }
        favoritesNews.remove(at: indexPath.row)
        
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
