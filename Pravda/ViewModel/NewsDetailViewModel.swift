//
//  DetailNewsViewModel.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 18/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

class NewsDetailViewModel: NewsDetailViewModelType {
   
    private var article: News
    
    var title: String {
        return article.title
    }
    
    init(article: News) {
        self.article = article
    }
}
