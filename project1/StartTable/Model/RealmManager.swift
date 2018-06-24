//
//  RealmManager.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 24.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import RealmSwift

class RealmManager {
    private var database: Realm
    static let sharedInstance = RealmManager()
    private init() {
        database = try! Realm()
    }
    
    func getDataFromDB() -> Results<Girl> {
        let results: Results<Girl> = database.objects(Girl.self)
        return results
    }
    
    func addData(object: Girl) {
        try! database.write {
            database.add(object, update: true)
            print("Added new object")
        }
    }
    
    func deleteAllDatabase()  {
        try! database.write {
            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: Girl) {
        try! database.write {
            database.delete(object)
        }
    }
}
