//
//  MovieDatabaseAPI.swift
//  Movie Me Mine
//
//  Created by SFurlani on 8/27/15.
//  Copyright © 2015 Optoro. All rights reserved.
//

import Foundation
import SwiftyJSON

final class MovieDatabaseAPI {
    
    // MARK: - Types
    
    typealias ConfigureCallback = (database: MovieDatabaseAPI) -> ()
    typealias MovieListCallback = (movies: [Movie]?) -> ()

    enum APIErrorType : ErrorType {
        case UnableToFormURL(String)
        case InvalidResponse(Int?)
        case InvalidData(NSData?)
        case InvalidJSON
    }
    
    struct EndPoints {
        static let configuration = "/configuration"
        static let searchMovies = "/search/movie"
        static let popularMovies = "/movie/popular"
    }
    
    // MARK: - Properties
    
    private let apiKey = "1419277c31b39f8ca591b8da5d77b5f8" // TODO: Put in Keychain
    
    private let basePath: String
    
    private let session: NSURLSession
    
    private(set) var configuration: Configuration!
    
    init(rootPath: String = "http://api.themoviedb.org/3") {
        basePath = rootPath
        session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
    }
    
    deinit {
        session.invalidateAndCancel()
    }
    
    // MARK: - Network Calls
    
    func configure(callback: ConfigureCallback?) {
        let configureURL = buildURL(EndPoints.configuration)
        
        let task = session.dataTaskWithURL(configureURL) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            
            defer {
                callback?(database: self)
            }
            
            do {
                let json = try self.parseDataTaskToJSON(data, response: response, error: error)
                self.configuration = Configuration(json: json)
            }
            catch {
                print(error)
            }
            
        }
        
        task.resume()
    }
    
    func popularMovies(callback: MovieListCallback?) {
        let popularURL = buildURL(EndPoints.popularMovies, parameters: ["page":"1"])
        
        let task = session.dataTaskWithURL(popularURL) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            do {
                let json = try self.parseDataTaskToJSON(data, response: response, error: error)
                
                let results = json["results"]
                
                let movies = results.arrayValue.map { Movie(json: $0) }
                
                callback?(movies: movies)
            }
            catch {
                print(error)
                callback?(movies: nil)
            }
        }
        
        task.resume()
        
    }
    
    // MARK: - Helper Functions
    
    private func buildURL(endpoint: String, parameters: [String:String]? = nil) -> NSURL {
        var path = basePath + endpoint + "?api_key=\(apiKey)"
        if let parameters = parameters {
            let pairs = parameters.map { (key: String, value: String) -> String in
                if let escapedValue = value.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet()) {
                    return "&\(key)=\(escapedValue)"
                }
                return ""
            }
            
            path.appendContentsOf(pairs.joinWithSeparator(""))
            
        }
        return NSURL(string: path)!
    }
    
    
    private func parseDataTaskToJSON(data: NSData?, response: NSURLResponse?, error: NSError?) throws -> JSON {
        
        if let error = error {
            throw error
        }
        
        guard let response = response as? NSHTTPURLResponse else {
            throw APIErrorType.InvalidResponse(nil)
        }
        
        guard response.statusCode == 200 else {
            throw APIErrorType.InvalidResponse(response.statusCode)
        }
        
        guard let data = data else {
            throw APIErrorType.InvalidData(nil)
        }
        
        let json = JSON(data: data)
        
        if let error = json.error {
            throw error
        }
        
        return json
    }

}



