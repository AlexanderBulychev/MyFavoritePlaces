//
//  StorageManager.swift
//  MyFavoritePlaces
//
//  Created by asbul on 05.07.2022.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {

    static func saveObject(_ place: Place) {
        try! realm.write {
            realm.add(place)
        }
    }
}
