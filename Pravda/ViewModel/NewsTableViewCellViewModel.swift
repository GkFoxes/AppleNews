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
        return article.author ?? nil
    }
    
    var date: String? {
        let dateString = article.publishedAt
        let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let newFormat = DateFormatter()
        newFormat.dateFormat = "HH:mm"
        
        guard let preDate = dateString else { return nil }
        guard let date = dateFormatter.date(from: preDate) else { return nil }
        let articleDate = newFormat.string(from: date)
        
        return articleDate
    }
    
    init(article: NewsAPI) {
        self.article = article
    }
}
