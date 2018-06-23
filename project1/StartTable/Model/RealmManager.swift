//
//  UpdateStartTable.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 23.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation
import RealmSwift

//class RealmManager {
//    private var realm: Realm
//    static let sharedInstance = RealmManager()
//    private init() {
//        realm = try! Realm()
//    }
//    
//    func getDataFromDB() -> Results<Girl> {
//        let results: Results<Girl> = realm.objects(Girl.self)
//        return results
//    }
//    
//    func addData(object: Girl) {
//        try! realm.write {
//            realm.add(girlsList, update: true)
//            print("Added new object")
//        }
//    }
//    
//    func deleteAllFromDatabase() {
//        try! realm.write {
//            realm.deleteAll()
//        }
//    }
//    
//    func deleteFromDb(object: Girl) {
//        try! realm.write {
//            realm.delete(object)
//        }
//    }
//}
