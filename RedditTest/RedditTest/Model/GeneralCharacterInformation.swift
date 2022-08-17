//
//  GeneralCharacterInformation.swift
//  RedditTest
//
//  Created by Gabriel Lupu on 09.06.2022.
//

import UIKit
import SwiftyJSON

struct GeneralCharacterInformation {


    var info: InfoModel?
    var results: [CharacterModel]?

    init?(json: JSON) {
        self.info = InfoModel(json: json["info"])
        self.results = json["results"].array?.compactMap { CharacterModel(json: $0) }
    }
}
