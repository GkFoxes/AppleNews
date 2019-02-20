//
//  CategoryViewModel.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 20/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

class CategoryViewModel: CategoryTableViewViewModelType {
    
    var categories: [Category] = [
        Category(id: 0, name: "News", nameAPI: "general", isChoise: false),
        Category(id: 1, name: "Business", nameAPI: "business", isChoise: false),
        Category(id: 2, name: "Entertainment", nameAPI: "entertainment", isChoise: false),
        Category(id: 3, name: "Health", nameAPI: "health", isChoise: false),
        Category(id: 4, name: "Science", nameAPI: "science", isChoise: false),
        Category(id: 5, name: "Sports", nameAPI: "sports", isChoise: false),
        Category(id: 6, name: "Technology", nameAPI: "technology", isChoise: false)
    ]
    
    // MARK: - Table Data
    
    func numberOfRows() -> Int {
        return categories.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CategoryTableViewCellViewModel? {
        let category = categories[indexPath.row]
        return CategoryTableViewCellViewModel(category: category)
    }
    
    func setCategory(completion: @escaping() -> ()) {
        for item in categories {
            if item.isChoise == true {
                categories[item.id].isChoise = false
                completion()
            }
        }
        print(categories)
    }
    
    func chooseCategory(forIndexPath indexPath: IndexPath, isSet set: Bool) {
        if set {
            categories[indexPath.row].isChoise = true
        } else {
            categories[indexPath.row].isChoise = false
        }
    }
}
