//
//  FavoritesTableViewCellViewModel.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 21/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class FavoritesTableViewCellViewModel: FavoritesTableViewCellViewModelType {
    
    private var article: NewsAPI
    
    var title: String? {
        return article.title ?? nil
    }
    
    var author: String? {
        return article.author ?? nil
    }
    
    var date: String? {
        return article.publishedAt ?? nil
    }
    
    var image: UIImage? {
        return UIImage(named: "noImage") ?? nil
    }
    
    init(article: NewsAPI) {
        self.article = article
    }
}
