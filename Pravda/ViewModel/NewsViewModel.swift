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
    
    var news: News?
    
    func numberOfRows() -> Int {
        guard let news = news else { return 0 }
        guard let articles = news.articles else { return 0 }
        return articles.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsTableViewCellViewModelType? {
        guard let news = news else { return nil }
        guard let articles = news.articles else { return nil }
        let article = articles[indexPath.row]
        return NewsTableViewCellViewModel(article: article)
    }
    
    func viewModelForSelectedRow() -> NewsDetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        guard let news = news else { return nil }
        guard let articles = news.articles else { return nil }
        return NewsDetailViewModel(article: articles[selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func getInitialData(completion: @escaping() -> ()) {
        NetworkManager.initialData { (result) in
            switch result {
            case .success(let posts):
                self.news = posts
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
}
