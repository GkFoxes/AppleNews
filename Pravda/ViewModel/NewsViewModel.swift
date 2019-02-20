//
//  NewsViewModel.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 18/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

class NewsViewModel: NewsTableViewViewModelType {
    
    private var selectedIndexPath: IndexPath?
    
    var news =
        News(status: "ok", totalResults: 3, articles: [
            NewsAPI(source: nil, author: "CNN", title: "BREAKING something", description: nil, url: nil, urlToImage: nil, publishedAt: "14:55"),
            NewsAPI(source: nil, author: "P2P", title: "What is this?", description: nil, url: nil, urlToImage: nil, publishedAt: "12:41"),
            NewsAPI(source: nil, author: "PostPravda", title: "Okey, but not okey. What are he waiting for? Trouble", description: nil, url: nil, urlToImage: nil, publishedAt: "9:58")
            ])
    
    func numberOfRows() -> Int {
        guard let articles = news.articles else { return 0 }
        return articles.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsTableViewCellViewModelType? {
        guard let articles = news.articles else { return nil }
        let article = articles[indexPath.row]
        return NewsTableViewCellViewModel(article: article)
    }
    
    func viewModelForSelectedRow() -> NewsDetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        guard let articles = news.articles else { return nil }
        return NewsDetailViewModel(article: articles[selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
}
