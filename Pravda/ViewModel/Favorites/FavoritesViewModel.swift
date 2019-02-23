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
    
    //var news: News?
    var favoritesNews: [FavoritesNews]? = [
//        NewsAPI(source: nil, author: "Macdigger", title: "Macdigger", description: nil, url: "https://www.macdigger.ru", urlToImage: "https://www.macdigger.ru/crop/85/85/storage/app/uploads/public/5bb/4f0/868/5bb4f0868e0d3171677799.jpg", publishedAt: "21.08 14:55"),
//        NewsAPI(source: nil, author: "P2P", title: "Samsung", description: nil, url: "https://www.macdigger.ru/news/post/samsung-operedila-apple-v-innovaciyah-no-sovershila-oshibku-pri-zapuske-svoego-flagmana", urlToImage: "https://www.macdigger.ru/storage/app/media/uploaded-files/galaxys10-6-920x613.jpg", publishedAt: "21.08 9:40"),
//        NewsAPI(source: nil, author: "PostPravda", title: "12 Safari", description: nil, url: "https://www.macdigger.ru/news/post/12-sovetov-po-safari-dlya-iphone-kotorye-dolzhen-znat-kazhdyj", urlToImage: "https://www.macdigger.ru/storage/app/media/uploaded-files/12-Safari-Tips-Close-Tabs%201.jpg", publishedAt: "11.08 16:55"),
//        NewsAPI(source: nil, author: "CNN", title: "BREAKING something", description: nil, url: nil, urlToImage: nil, publishedAt: "14:55"),
//        NewsAPI(source: nil, author: "P2P", title: "What is this?", description: nil, url: nil, urlToImage: nil, publishedAt: "12:41"),
//        NewsAPI(source: nil, author: "PostPravda", title: "Okey, but not okey. What are he waiting for? Trouble Okey, but not okey. What are he waiting for? Trouble Okey, but not okey. What are he waiting for? Trouble", description: nil, url: nil, urlToImage: nil, publishedAt: "9:58"),
//        NewsAPI(source: nil, author: "PostPravda", title: "12 Safari", description: nil, url: "https://www.macdigger.ru/news/post/12-sovetov-po-safari-dlya-iphone-kotorye-dolzhen-znat-kazhdyj", urlToImage: "https://www.macdigger.ru/storage/app/media/uploaded-files/12-Safari-Tips-Close-Tabs%201.jpg", publishedAt: "9:58")
    ]
    
    var context: NSManagedObjectContext!
    var fetchResultsController: NSFetchedResultsController<FavoritesNews>!
    
    // MARK: - Table Data
    
    func numberOfRows() -> Int {
        guard let favoritesNews = favoritesNews else { return 0 }
        return favoritesNews.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritesTableViewCellViewModelType? {
        guard let favoritesNews = favoritesNews else { return nil }
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
                favoritesNews = fetchResultsController.fetchedObjects!
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
