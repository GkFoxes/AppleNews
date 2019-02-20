//
//  DetailNewsViewModel.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 18/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

class NewsDetailViewModel: NewsDetailViewModelType {
   
    private var article: NewsAPI
    
    var title: String {
        return article.title ?? ""
    }
    
    init(article: NewsAPI) {
        self.article = article
    }
}
