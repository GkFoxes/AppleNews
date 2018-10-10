//
//  News.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 24.08.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation

struct News: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [DataAPI]?
    
    init(status: String?, totalResults: Int?, articles: [DataAPI]?) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}
