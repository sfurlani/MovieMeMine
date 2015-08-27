//
//  MovieDatabaseAPI.swift
//  Movie Me Mine
//
//  Created by SFurlani on 8/27/15.
//  Copyright © 2015 Optoro. All rights reserved.
//

import Foundation

final class MovieDatabaseAPI {
    
    enum APIErrorType : ErrorType {
        case UnableToFormURL(String)
    }
    
    struct EndPoints {
        static let configuration = "/configuration"
        static let searchMovies = "/search/movie"
    }
    
    typealias Callback = (dataSource: MovieDataSource) -> ()
    
    private let baseURL: NSURL
    
    private let session: NSURLSession
    
    init(rootPath: String = "http://api.themoviedb.org/3/") throws {
        session = NSURLSession()
        
        guard let url = NSURL(string: rootPath) else {
            throw APIErrorType.UnableToFormURL(rootPath)
        }
        
        baseURL = url
    }
    
    func configure(callback: Callback?) {
        let configureURL = NSURL(string: EndPoints.configuration, relativeToURL: baseURL)!
        let task = session.dataTaskWithURL
    }

}


struct Configuration {


}
