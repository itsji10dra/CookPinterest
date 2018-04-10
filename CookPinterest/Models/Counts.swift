//
//  Counts.swift
//  CookPinterest
//
//  Created by Jitendra on 11/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

struct Counts: Mappable {
    
    var pins: Int?
    
    var collaborators: Int?
    
    var followers: Int?
    
    // MARK: - Mappable
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        pins            <- map["pins"]
        collaborators   <- map["collaborators"]
        followers       <- map["followers"]
    }
}
