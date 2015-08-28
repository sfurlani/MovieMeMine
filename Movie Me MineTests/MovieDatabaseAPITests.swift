//
//  MovieDatabaseAPITests.swift
//  Movie Me Mine
//
//  Created by SFurlani on 8/27/15.
//  Copyright © 2015 Optoro. All rights reserved.
//

import XCTest
@testable import Movie_Me_Mine

extension Movie {
 
    /// Test Data?
    init() {

        backdropPath = "/sLbXneTErDvS3HIjqRWQJPiZ4Ci.jpg"
        posterPath = "/s5uMY8ooGRZOL0oe4sIvnlTsYQO.jpg"
        id = 211672
        title = "Minions"
        overview = "Minions Stuart, Kevin and Bob are recruited by Scarlet Overkill, a super-villain who, alongside her inventor husband Herb, hatches a plot to take over the world."
        releaseDate = Optional("2015-06-25")
        runtime = nil
        rating = Optional(6.9)
        votes = 1052
    }
    
}

/// Integration Test for Database API
class MovieDatabaseAPITests: XCTestCase {
    
    var database: MovieDatabaseAPI!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        database = MovieDatabaseAPI()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConfiguration() {
        
        let expectation = expectationWithDescription("Downloading Configuration")
        
        database.configure { (database) -> () in
            XCTAssertNotNil(database.configuration, "Configuration Should Not Be Nil")
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5.0) {
            if let error = $0 {
                XCTFail("Error: \(error)")
            }
        }
    }
    
    func testPopularMovies() {
        let count = 20
        let expectation = expectationWithDescription("Downloading Popular Movies")
        
        database.popularMovies {
            guard let movies = $0 else {
                XCTFail("No Movies Returned")
                return
            }
            
            XCTAssertEqual(movies.count, count, "Should return \(count) movies, returned \(movies.count)")
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5.0) {
            if let error = $0 {
                XCTFail("Error: \(error)")
            }
        }
    }
    
    func testSearchMovies() {
        let search = "bob"
        let expect = "What About Bob?"
        let expectation = expectationWithDescription("Downloading Searched Movies: \(search)")
        
        database.movieSearch(search) {
            guard let movies = $0 else {
                XCTFail("No Movies Returned")
                return
            }
            
            let titles = movies.map { $0.title }
            
            XCTAssertTrue(titles.contains(expect), "Query did not return: '\(expect)'")
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5.0) {
            if let error = $0 {
                XCTFail("Error: \(error)")
            }
        }
    }
    
    func testMovieDetail() {
        // minions
        let testMovie = Movie()
        
        let expectation = expectationWithDescription("Downloading Minion's Movie")
        
        database.fetchMovieDetails(testMovie) {
            guard let movie = $0 else {
                XCTFail("Did not return a movie")
                return
            }
            
            XCTAssertEqual(testMovie.id, movie.id, "Mismatched ID: \(testMovie.id) vs. \(movie.id)")
            XCTAssertNotNil(movie.runtime, "Missing Property: runtime")
            
            expectation.fulfill()
            
        }
        
        waitForExpectationsWithTimeout(5.0) {
            if let error = $0 {
                XCTFail("Error: \(error)")
            }
        }
    }
    
    func testMoviePoster() {
        // minions
        let testMovie = Movie()
        
        let expectation = expectationWithDescription("Downloading Minion's Poster")
        database.configure() { (_) in
            self.database.fetchPosterImage(testMovie) {
                guard let _ = $0 else {
                    XCTFail("Did not return image")
                    return
                }
                
                
                expectation.fulfill()
                
            }
        }
        
        waitForExpectationsWithTimeout(30.0) {
            if let error = $0 {
                XCTFail("Error: \(error)")
            }
        }
    }
    
}
