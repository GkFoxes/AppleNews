//
//  SharedManager.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 10/10/2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit

class SharedManager {
    
    var pageSearch = 1
    var cancelOrSave = false
    var imageCache = NSCache<AnyObject, UIImage>()
    
    var categories: [Category] = [
        Category(id: 0, name: "Новости", nameAPI: "", isChoise: true),
        Category(id: 1, name: "Бизнес", nameAPI: "business", isChoise: false),
        Category(id: 2, name: "Развлечения", nameAPI: "entertainment", isChoise: false),
        Category(id: 3, name: "Здоровье", nameAPI: "health", isChoise: false),
        Category(id: 4, name: "Наука", nameAPI: "science", isChoise: false),
        Category(id: 5, name: "Спорт", nameAPI: "sports", isChoise: false),
        Category(id: 6, name: "Технологии", nameAPI: "technology", isChoise: false)]
    
    static let shared = SharedManager()
    
    private init() {}
    
    func reset() {
        pageSearch = 1
        cancelOrSave = false
        imageCache = NSCache<AnyObject, UIImage>()
    }
}
