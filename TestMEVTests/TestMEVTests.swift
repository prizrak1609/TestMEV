//
//  TestMEVTests.swift
//  TestMEVTests
//
//  Created by Dima Gubatenko on 27.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import XCTest
@testable import TestMEV

class TestMEVTests: XCTestCase {

    let database = Database()
    
    override func setUp() {
        super.setUp()
        database.deleteAll()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        database.deleteAll()
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertTrue(true)
    }

    func testSearchMovies() {
        let server = Server()
        let wait = expectation(description: "text search movies")
        wait.expectedFulfillmentCount = 2
        var resultModels = [MovieModel]()
        server.searchMovies(title: "Transformers") { result in
            switch result {
                case .failure(let error): XCTAssertTrue(false, error.localizedDescription)
                case .success(let models):
                    resultModels = models
                    wait.fulfill()
            }
        }
        waitForExpectations(timeout: 200, handler: nil)
        XCTAssertFalse(resultModels.isEmpty)
    }

    func testDatabaseSave() {
        let movie = MovieModel()
        movie.title = "1"
        movie.searchWorld = "1"
        let movie1 = MovieModel()
        database.save(movie: movie)
        let _model = database.getMovies(by: "1")
        XCTAssertFalse(_model.isEmpty)
        XCTAssertTrue(_model.first?.title == "1")
        XCTAssertTrue(_model.first?.searchWorld == "1")
    }
}
