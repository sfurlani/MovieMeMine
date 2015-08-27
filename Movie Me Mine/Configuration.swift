//
//  Configuration.swift
//  Movie Me Mine
//
//  Created by SFurlani on 8/27/15.
//  Copyright © 2015 Optoro. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Configuration {
    
    let baseURL: String
    let secureURL: String
    let backdropSizes: [String]
    let logoSizes: [String]
    let posterSizes: [String]
    let profileSizes: [String]
    let stillSizes: [String]
    let changeKeys: [String]
    
    init(json: JSON) {
        
        let images = json["images"]
        
        baseURL         = images["base_url"].stringValue
        secureURL       = images["secure_base_url"].stringValue
        
        backdropSizes   = images["backdrop_sizes"].arrayValue.map { $0.stringValue }
        logoSizes       = images["logo_sizes"].arrayValue.map { $0.stringValue }
        posterSizes     = images["poster_sizes"].arrayValue.map { $0.stringValue }
        profileSizes    = images["profile_sizes"].arrayValue.map { $0.stringValue }
        stillSizes      = images["still_sizes"].arrayValue.map { $0.stringValue }
        
        changeKeys      = json["change_keys"].arrayValue.map { $0.stringValue }
    }
}
