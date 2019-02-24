//
//  CategoryViewModel.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 20/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

class CategoryViewModel: CategoryTableViewViewModelType {
    
    var categories: [Category] = []
    
    // MARK: - Table Data
    
    func numberOfRows() -> Int {
        return categories.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CategoryTableViewCellViewModel? {
        let category = categories[indexPath.row]
        return CategoryTableViewCellViewModel(category: category)
    }

    init(categories: [Category]) {
        self.categories = categories
    }
}
