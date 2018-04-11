//
//  Image.swift
//  CookPinterest
//
//  Created by Jitendra on 11/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

struct Image: Mappable {
    
    var url: URL?
    
    var width: Int?
    
    var height: Int?
    
    // MARK: - Mappable
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        url         <- (map["url"], URLTransform())
        width       <- map["width"]
        height      <- map["height"]
    }
}
