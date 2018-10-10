//
//  Source.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 10/10/2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation

struct Source: Codable {
    var id: String?
    var name: String?
    
    init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
}
