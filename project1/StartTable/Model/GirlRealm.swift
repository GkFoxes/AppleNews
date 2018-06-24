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
var girlsList: Results<Girl>!

class Girl: Object {
    @objc dynamic var name = ""
    @objc dynamic var girlID = ""
    
    override static func primaryKey() -> String? {
        return "girlID"
    }
    
    convenience init(name: String, girlID: String) {
        self.init()
        self.name = name
        self.girlID = girlID
    }
}

func girlInitial() {
    try! realm.write {
        realm.add(Girl(name: "Анджелина Джоли", girlID: "0"))
        realm.add(Girl(name: "Скарлетт Йоханссон", girlID: "1"))
        realm.add(Girl(name: "Меган Фокс", girlID: "2"))
        realm.add(Girl(name: "Шарлиз Терон", girlID: "3"))
        realm.add(Girl(name: "Моника Беллуччи", girlID: "4"))
        realm.add(Girl(name: "Натали Портман", girlID: "5"))
        realm.add(Girl(name: "Мила Кунис", girlID: "6"))
        realm.add(Girl(name: "Кира Найтли", girlID: "7"))
        realm.add(Girl(name: "Дженнифер Лоуренс", girlID: "8"))
        realm.add(Girl(name: "Марго Робби", girlID: "9"))
    }
}
