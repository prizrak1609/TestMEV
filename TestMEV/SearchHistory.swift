//
//  SearchHistory.swift
//  TestMEV
//
//  Created by Dima Gubatenko on 27.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import Foundation
import RealmSwift

class SearchHistory : Object {

    dynamic var id = 0
    dynamic var movieTitle = ""

    override class func primaryKey() -> String? {
        return "id"
    }

    func incrementID() {
        // disable because Realm on his site says it useful in most cases
        // swiftlint:disable:next force_try
        let realm = try! Realm()
        let newId = (realm.objects(SearchHistory.self).max(ofProperty: "id") as Int? ?? 0) + 1
        id = newId
    }
}
