//
//  FavoritesTableViewCellViewModel.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 21/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

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
    
    var url: String? {
        return article.url ?? nil
    }
    
    var urlImage: String? {
        return article.urlToImage ?? nil
    }
    
    init(article: NewsAPI) {
        self.article = article
    }
}
