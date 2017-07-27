//
//  TrailerModel.swift
//  TestMEV
//
//  Created by Dima Gubatenko on 27.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class TrailerModel : Object {
    dynamic var urlPath = ""

    convenience init(json: JSON) {
        self.init()
        urlPath = json["videoUrl"].stringValue
    }

    override class func primaryKey() -> String? {
        return "urlPath"
    }
}
