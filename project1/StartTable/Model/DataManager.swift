//
//  DataManager.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 24.08.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit

var articlesToNews = [DataAPI(source: nil, author: nil, title: nil, description: nil, url: nil, urlToImage: nil, publishedAt: nil)]
var news = News(status: nil, totalResults: 0, articles: articlesToNews)

var pageSearch = 1
var totalInPage = news.totalResults

var imageCache = NSCache<AnyObject, UIImage>()

extension StartTableViewController {
    
    func getInitialData() {
        initialData { (result) in
            switch result {
            case .success(let posts):
                news = posts
                self.tableContent.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadDataFromNextPage() {
        loadNextPage{ (result) in
            switch result {
            case .success(let posts):
                
                guard let addNews = posts.articles else { return }
                for item in addNews {
                    news.articles?.append(item)
                    self.tableContent.reloadData()
                }
            case .failure(let error):
                print(error)
                self.tableContent.reloadData()
            }
        }
    }
}
