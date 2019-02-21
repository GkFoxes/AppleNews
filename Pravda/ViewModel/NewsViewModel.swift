//
//  NewsViewModel.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 18/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class NewsViewModel: NewsTableViewViewModelType {
    
    // MARK: Properties
    
    var news: News?
    private var selectedIndexPath: IndexPath?
    var pageSearch = 1
    var category = Category(id: 0, name: "News", nameAPI: "general", isChoise: true)
    
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    // MARK: - Table Data
    
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
    
    func setSpinner(forTable table: UITableView) {
        spinner.color = UIColor.black
        spinner.startAnimating()
        table.backgroundView = spinner
    }
    
    func removeSpinner() {
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    
    // MARK: - Networking
    
    func getInitialData(completion: @escaping() -> ()) {
        let category = chooseCategory()
        pageSearch = 1
        NetworkManager.getData(forCategory: category.nameAPI, withPage: 1) { (result) in
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
    
    func loadNextPage(completion: @escaping() -> ()) {
        guard let news = news else { return }
        guard let newsCount = news.totalResults else { return }
        
        if newsCount > numberOfRows() {
            pageSearch += 1
            let category = chooseCategory()
            NetworkManager.getData(forCategory: category.nameAPI, withPage: pageSearch) { (result) in
                switch result {
                case .success(let posts):
                    guard let addNews = posts.articles else { return }
                    guard news.articles != nil else { return }
                    
                    for item in addNews {
                        self.news!.articles!.append(item)
                    }
                    completion()
                case .failure(let error):
                    print(error)
                    completion()
                }
            }
        }
    }
    
    func chooseCategory() -> Category {
        for item in CategoryTableViewController.categories {
            if (item.id != 0) && (item.isChoise == true) {
                self.category = item
                break
            }
        }
        
        return category
    }
}
