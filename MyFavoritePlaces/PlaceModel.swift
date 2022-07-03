//
//  PlaceModel.swift
//  MyFavoritePlaces
//
//  Created by asbul on 26.06.2022.
//

import UIKit

struct Place {
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var description: String?
    var restaurantImage: String?

    static let restaurantNames = [
        "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
        "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
        "Speak Easy", "Morris Pub", "Вкусные истории",
        "Классик", "Love&Life", "Шок", "Бочка"
    ]

    static func getPlaces() -> [Place] {
        var places: [Place] = []
        for place in restaurantNames {
            places.append(Place(
                name: place,
                location: "Ufa",
                type: "rest",
                image: nil,
                description: nil,
                restaurantImage: place
            ))
        }
        return places
    }
}
