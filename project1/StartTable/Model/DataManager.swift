//
//  DataManager.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 24.08.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit

var articlesToNews = [DataAPI(source: nil, author: nil, title: nil, description: nil, url: nil, urlToImage: nil, publishedAt: nil)]
var news = News(status: nil, totalResults: nil, articles: articlesToNews)

extension StartTableViewController {
    
    func getInitialData() {
        initialData { (result) in
            switch result {
            case .success(let posts):
                news.articles = posts.articles
                self.tableContent.reloadData()
                print("YES")
            case .failure(let error):
                print(error)
            }
        }
    }
}
