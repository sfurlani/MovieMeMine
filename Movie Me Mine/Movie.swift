//
//  Movie.swift
//  Movie Me Mine
//
//  Created by SFurlani on 8/27/15.
//  Copyright © 2015 Optoro. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Movie {

    let adult: Bool
    let posterPath: String
    let id: UInt
    let title: String
    let overview: String
    let releaseDate: String?
    let rating: Float
    
    init(json: JSON) {
        
        adult = json["adult"].boolValue
        posterPath = json["poster_path"].stringValue
        id = json["id"].uIntValue
        title = json["title"].stringValue
        overview = json["overview"].stringValue
        releaseDate = json["release_date"].string
        rating = json["vote_averate"].floatValue
        
    }

}
