//
//  NewsTableViewCellViewModel.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 18/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

class NewsTableViewCellViewModel: NewsTableViewCellViewModelType {

    private var article: News
    
    var title: String {
        return article.title
    }
    
    var author: String {
        return article.author
    }
    
    var date: String {
        return article.date
    }
    
    init(article: News) {
        self.article = article
    }
}
