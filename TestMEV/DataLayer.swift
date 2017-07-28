//
//  DataLayer.swift
//  TestMEV
//
//  Created by Dima Gubatenko on 28.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import Foundation

final class DataLayer {
    fileprivate let server = Server()
    fileprivate let database = Database()

    func searchMovies(title: String, _ completion: @escaping ServerSearchMoviesCompletion) {
        let movies = database.getMovies(by: title)
        if !movies.isEmpty {
            completion(.success(movies))
        } else {
            server.searchMovies(title: title) { [weak self] result in
                guard let welf = self else { return }
                if case .success(let models) = result {
                    for model in models {
                        welf.database.save(movie: model)
                    }
                }
                completion(result)
            }
        }
    }

    func saveToSearchHistory(movie: MovieModel) {
        database.saveToSearchHistory(movie: movie)
    }

    func getSearchHistory() -> [MovieModel] {
        return database.getSearchHistory()
    }
}
