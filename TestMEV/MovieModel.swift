//
//  MoviewModel.swift
//  TestMEV
//
//  Created by Dima Gubatenko on 27.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class RealmString : Object {
    var stringValue = ""

    convenience init(json: JSON) {
        self.init()
        stringValue = json.stringValue
    }
}

class MovieModel : Object {
    dynamic var thumbURLPath = ""
    dynamic var largeURLPath = ""
    dynamic var title = ""
    dynamic var raiting = ""
    dynamic var releaseDateString = ""
    dynamic var director = ""
    dynamic var siteURLPath = ""
    dynamic var movieLength = 0
    var trailers = List<TrailerModel>()
    var casts = List<CastModel>()
    dynamic var imdbRaiting = ""
    var genres = List<RealmString>()
    dynamic var story = ""
    dynamic var movieDescription = ""
    var stars = List<RealmString>()
    var writers = List<RealmString>()
    dynamic var searchWorld = ""

    override class func primaryKey() -> String? {
        return "title"
    }

    convenience init(json: JSON) {
        self.init()
        title = json["title"].stringValue
        raiting = json["content_rating"].stringValue
        releaseDateString = json["release_date"].stringValue
        director = json["director"].stringValue
        siteURLPath = json["url"]["url"].stringValue
        movieLength = json["length"].intValue

        let trailersArray = json["trailer"].arrayValue.map { TrailerModel(json: $0) }
        trailers.append(objectsIn: trailersArray)

        let castsArray = json["cast"].arrayValue.map { CastModel(json: $0) }
        casts.append(objectsIn: castsArray)

        imdbRaiting = json["rating"].stringValue

        let genreArray = json["genre"].arrayValue.map { RealmString(json: $0) }
        genres.append(objectsIn: genreArray)

        story = json["storyline"].stringValue
        movieDescription = json["description"].stringValue

        let starsArray = json["stars"].arrayValue.map { RealmString(json: $0) }
        stars.append(objectsIn: starsArray)

        let writersArray = json["writers"].arrayValue.map { RealmString(json: $0) }
        writers.append(objectsIn: writersArray)

        thumbURLPath = json["poster"]["thumb"].stringValue
        largeURLPath = json["poster"]["large"].stringValue
    }
}
