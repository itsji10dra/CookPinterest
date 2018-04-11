//
//  UserData.swift
//  CookPinterest
//
//  Created by Jitendra on 10/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

struct User: Mappable {
    
    private(set) var id: Int?
    
    var firstName: String?
    
    var lastName: String?
    
    var url: URL?
    
    // MARK: - Mappable
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        firstName   <- map["first_name"]
        lastName    <- map["last_name"]
        url         <- (map["url"], URLTransform())
    }
}
