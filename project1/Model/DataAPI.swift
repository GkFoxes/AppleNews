//
//  DataAPI.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 10/10/2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation

struct DataAPI: Codable {
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    
    init(source: Source?, author: String?, title: String?, description: String?, url: String?, urlToImage: String?, publishedAt: String?) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
}
