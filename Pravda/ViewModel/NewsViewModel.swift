//
//  NewsViewModel.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 18/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

class NewsViewModel: NewsTableViewViewModelType {
    
    var news = [
        News(title: "BREAKING something", author: "CNN", date: "14:55"),
        News(title: "What is this?", author: "P2P", date: "12:41"),
        News(title: "Okey, but not okey. What are he waiting for? Trouble", author: "PostPravda", date: "9:58")
    ]
    
    func numberOfRows() -> Int {
        return news.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsTableViewCellViewModelType? {
        let article = news[indexPath.row]
        return NewsTableViewCellViewModel(article: article)
    }
}
