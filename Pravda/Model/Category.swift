//
//  Category.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 20/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
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
