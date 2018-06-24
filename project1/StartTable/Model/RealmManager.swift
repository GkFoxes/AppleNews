//
//  UpdateStartTable.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 23.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    // delete table
    func deleteDatabase() {
        try! realm?.write({
            realm?.deleteAll()
        })
    }
    
    // delete particular object
    func deleteObject(objs : Object) {
        try? realm!.write ({
            realm?.delete(objs)
        })
    }
    
    //Save array of objects to database
    func saveObjects(objs: Object) {
        try? realm!.write ({
            // If update = false, adds the object
            realm?.add(objs, update: false)
        })
    }
    
    // editing the object
    func editObjects(objs: Object) {
        try? realm!.write ({
            // If update = true, objects that are already in the Realm will be
            // updated instead of added a new.
            realm?.add(objs, update: true)
        })
    }
    
    //Returs an array as Results<object>?
    func getObjects(type: Object.Type) -> Results<Object>? {
        return realm!.objects(type)
    }
    
    func incrementID() -> Int {
        return (realm!.objects(Girl.self).max(ofProperty: "girlID") as Int? ?? 0) + 1
    }
}
