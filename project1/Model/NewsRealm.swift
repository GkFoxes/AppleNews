//
//  NewsRealm.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 29.08.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation
import RealmSwift

class NewsRealm: Object {
    @objc dynamic var sourceName: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var descriptionRealm: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var urlToImage: String = ""
    @objc dynamic var publishedAt: String = ""
    @objc dynamic var createdAt = NSDate()
    
    convenience init(sourceName: String, author: String, title: String, descriptionRealm: String, url: String, urlToImage: String, publishedAt: String) {
        self.init()
        self.sourceName = sourceName
        self.author = author
        self.title = title
        self.descriptionRealm = descriptionRealm
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
}
