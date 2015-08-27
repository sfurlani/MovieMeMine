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
    
    typealias Callback = (database: MovieDatabaseAPI) -> ()
    
    enum APIErrorType : ErrorType {
        case UnableToFormURL(String)
        case InvalidResponse(Int?)
        case InvalidData(NSData?)
        case InvalidJSON
    }
    
    struct EndPoints {
        static let configuration = "/configuration"
        static let searchMovies = "/search/movie"
    }
    
    /// TODO: Put in Keychain
    private let apiKey = "1419277c31b39f8ca591b8da5d77b5f8"
    
    private let basePath: String
    
    private let session: NSURLSession
    
    private var configuration: Configuration?
    
    init(rootPath: String = "http://api.themoviedb.org/3/") throws {
        session = NSURLSession()
        basePath = rootPath
    }
    
    func configure(callback: Callback?) {
        let configureURL = buildURL(EndPoints.configuration)
        
        let task = session.dataTaskWithURL(configureURL) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
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




