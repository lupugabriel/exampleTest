//
//  InfoModel.swift
//  RedditTest
//
//  Created by Gabriel Lupu on 09.06.2022.
//

import UIKit
import SwiftyJSON

struct InfoModel {

    var count: Int?
    var pages: Int?
    var next: String?
    var prev: String?

    init?(json: JSON) {
        self.count = json["count"].int
        self.pages = json["pages"].int
        self.next = json["next"].string
        self.prev = json["prev"].string
    }
}
