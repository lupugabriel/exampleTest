//
//  CharacterModel.swift
//  RedditTest
//
//  Created by Gabriel Lupu on 09.06.2022.
//

import UIKit
import SwiftyJSON

struct CharacterModel {

    var id: Int?
    var name: String?
    var status: String?
    var gender: String?
    var species: String?
    var image: String?
    var origin: OrginModel?
    var location: LocationModel?


    init?(json: JSON) {
        self.id = json["id"].int
        self.name = json["name"].string
        self.gender = json["gender"].string
        self.status = json["status"].string
        self.species = json["species"].string
        self.image = json["image"].string
        self.origin = OrginModel(json: json["origin"])
        self.location = LocationModel(json: json["location"])
    }
}

struct OrginModel {
    var name: String?
    var url: String?

    init?(json: JSON) {
        self.name = json["name"].string
        self.url = json["url"].string
    }
}

struct LocationModel {
    var name: String?
    var url: String?

    init?(json: JSON) {
        self.name = json["name"].string
        self.url = json["url"].string
    }
}
