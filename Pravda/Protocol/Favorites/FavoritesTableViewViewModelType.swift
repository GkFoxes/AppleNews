//
//  FavoritesTableViewViewModelType.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 21/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit
import CoreData

protocol FavoritesTableViewViewModelType {
    var favoritesNews: [FavoritesNews]? { get set }
    
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritesTableViewCellViewModelType?
    
    func initialCoreDataNews()
}
