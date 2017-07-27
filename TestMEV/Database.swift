//
//  Database.swift
//  TestMEV
//
//  Created by Dima Gubatenko on 27.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import Foundation
import RealmSwift

// disable because many time need write try! realm = Realm() or try! realm.write {}
// swiftlint:disable force_try
final class Database {

    // created for unit tests
    func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }

    func save(movie: MovieModel) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(movie, update: true)
        }
    }

    func saveToSearchHistory(movie: MovieModel) {
        let history = SearchHistory()
        history.incrementID()
        history.movieTitle = movie.title
        let realm = try! Realm()
        try! realm.write {
            realm.add(history, update: true)
        }
    }

    func getSearchHistory() -> [MovieModel] {
        let realm = try! Realm()
        let historyArray = realm.objects(SearchHistory.self).sorted(byKeyPath: "id", ascending: false)
        var result = [MovieModel]()
        for history in historyArray {
            let predicate = NSPredicate(format: "title = %@", history.movieTitle)
            let model = realm.objects(MovieModel.self).filter(predicate)
            result.append(contentsOf: model)
        }
        return result
    }

    func getMovies(by title: String) -> [MovieModel] {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "searchWorld = %@", title)
        let moviesArray = realm.objects(MovieModel.self).filter(predicate)
        var result = [MovieModel]()
        result.append(contentsOf: moviesArray)
        return result
    }
}
// swiftlint:enable force_try
