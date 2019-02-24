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
