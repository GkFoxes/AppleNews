//
//  File.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 22.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation
import RealmSwift

//var girlsList: Results<Girl> {
//    get {
//        return realm.objects(Girl.self)
//    }
//}
//var girlsList: Results<Girl>!

class Girl: Object {
    @objc dynamic var name = ""
    @objc dynamic var biography = ""
    @objc dynamic var link = ""
    
    convenience init(name: String, biography: String, link: String ) {
        self.init()
        self.name = name
        self.biography = biography
        self.link = link
    }
}
