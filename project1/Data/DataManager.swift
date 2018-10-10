//
//  DataManager.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 24.08.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit

extension StartTableViewController {
    
    func getInitialData() {
        initialData { (result) in
            switch result {
            case .success(let posts):
                self.news = posts
                self.totalInPage = self.news?.totalResults
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
                guard self.news != nil else { return }
                
                for item in addNews {
                    self.news!.articles?.append(item)
                    self.totalInPage = self.news?.totalResults
                    self.tableContent.reloadData()
                }
            case .failure(let error):
                print(error)
                self.tableContent.reloadData()
            }
        }
    }
}
