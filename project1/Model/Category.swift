//
//  Category.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 10/10/2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation

struct Category {
    let id: Int
    let name: String
    let nameAPI: String
    var isChoise: Bool
    
    init(id: Int, name: String, nameAPI: String, isChoise: Bool) {
        self.id = id
        self.name = name
        self.nameAPI = nameAPI
        self.isChoise = isChoise
    }
}
