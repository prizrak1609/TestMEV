//
//  File.swift
//  TestMEV
//
//  Created by Dima Gubatenko on 27.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias ServerSearchMoviesCompletion = (Result<[MovieModel]>) -> Void

final class Server {
    private let baseURLPath = "http://www.theimdbapi.org"

    func searchMovies(title: String, _ completion: @escaping ServerSearchMoviesCompletion) {
        let url = baseURLPath.appending("/api/find/movie")
        let params = ["title" : title]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(url, method: .get, parameters: params).responseJSON { [weak self] response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            guard let welf = self else { return }
            let jsonResult = welf.preParseJSON(response: response)
            if case .failure(let error) = jsonResult {
                completion(.failure(error))
                return
            }
            if case .success(let json) = jsonResult {
                let moviesArray = json.arrayValue.map { json -> MovieModel in
                    let movie = MovieModel(json: json)
                    movie.searchWorld = title
                    return movie
                }
                completion(.success(moviesArray))
            }
        }
    }

    private func preParseJSON(response: DataResponse<Any>) -> Result<JSON> {
        if let error = response.error ?? response.result.error {
            return .failure(error)
        }
        if let data = response.result.value {
            return .success(JSON(data))
        }
        return .failure(NSError(domain: NSLocalizedString("error when get json data", comment: "Server pre parse json"), code: 0, userInfo: nil))
    }
}
