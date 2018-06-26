//
//  File.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 22.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation
import RealmSwift

class Girl: Object {
    @objc dynamic var name = ""
    @objc dynamic var biography = ""
    @objc dynamic var link = ""
    @objc dynamic var createdAt = NSDate()
    
    convenience init(name: String, biography: String, link: String ) {
        self.init()
        self.name = name
        self.biography = biography
        self.link = link
    }
}
