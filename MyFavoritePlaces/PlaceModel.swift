//
//  PlaceModel.swift
//  MyFavoritePlaces
//
//  Created by asbul on 26.06.2022.
//

import RealmSwift
import UIKit

class Place: Object {
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var comment: String?

    let restaurantNames = [
        "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
        "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
        "Speak Easy", "Morris Pub", "Вкусные истории",
        "Классик", "Love&Life", "Шок", "Бочка"
    ]

    func savePlaces() {
        for place in restaurantNames {
            let image = UIImage(named: place)
            guard let imageData = image?.pngData() else { return }

            let newPlace = Place()
            newPlace.name = place
            newPlace.location = "Ufa"
            newPlace.type = "restaurant"
            newPlace.imageData = imageData

            StorageManager.saveObject(newPlace)
        }
    }
}
