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
    
    static var favoritesNews: [FavoritesNews] = []
    
    var context: NSManagedObjectContext!
    var fetchResultsController: NSFetchedResultsController<FavoritesNews>!
    
    // MARK: - Table Data
    
    func numberOfRows() -> Int {
        return FavoritesViewModel.favoritesNews.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritesTableViewCellViewModelType? {
        let article = FavoritesViewModel.favoritesNews[indexPath.row]
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
        FavoritesViewModel.favoritesNews.remove(at: indexPath.row)
        
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
    
    func updateCoreDataNews(atController controller: NSFetchedResultsController<NSFetchRequestResult>) {

        FavoritesViewModel.favoritesNews = controller.fetchedObjects as! [FavoritesNews]
    }
}
