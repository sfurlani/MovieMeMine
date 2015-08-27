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

    let backdropPath: String
    let posterPath: String
    let id: UInt
    let title: String
    let overview: String
    let releaseDate: String?
    let runtime: Int?
    let rating: Float?
    
    init(json: JSON) {
        backdropPath = json["backdrop_path"].stringValue
        posterPath = json["poster_path"].stringValue
        id = json["id"].uIntValue
        title = json["title"].stringValue
        overview = json["overview"].stringValue
        releaseDate = json["release_date"].string
        rating = json["vote_average"].float
        runtime = json["runtime"].int
    }

}
