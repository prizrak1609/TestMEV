//
//  CastModel.swift
//  TestMEV
//
//  Created by Dima Gubatenko on 27.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class CastModel : Object {
    dynamic var character = ""
    dynamic var imageURLPath = ""
    dynamic var siteURLPath = ""
    dynamic var name = ""

    convenience init(json: JSON) {
        self.init()
        character = json["character"].stringValue
        imageURLPath = json["image"].stringValue
        siteURLPath = json["link"].stringValue
        name = json["name"].stringValue
    }

    override class func primaryKey() -> String? {
        return "name"
    }
}
