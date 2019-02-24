//
//  NewsTableViewCellViewModel.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 18/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

class NewsTableViewCellViewModel: NewsTableViewCellViewModelType {

    private var article: NewsAPI
    
    var title: String? {
        return article.title ?? nil
    }
    
    var author: String? {
        guard let source = article.source else { return nil }
        return source.name ?? nil
    }
    
    var date: String? {
        let dateString = article.publishedAt
        let articleDate = DateToString.formatDateNews(dateString)
        return articleDate
    }
    
    init(article: NewsAPI) {
        self.article = article
    }
}
