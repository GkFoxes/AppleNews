//
//  CategoryTableViewCellViewModel.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 20/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

class CategoryTableViewCellViewModel: CategoryTableViewCellViewModelType {
    
    private var category: Category
    
    var title: String {
        return category.name
    }
    
    var photoString: String {
        return category.nameAPI
    }
    
    init(category: Category) {
        self.category = category
    }
}
