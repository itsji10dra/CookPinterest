//
//  Boards.swift
//  CookPinterest
//
//  Created by Jitendra on 11/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

struct Boards: Mappable {
    
    private(set) var id: String?
    
    var name: String?
    
    var description: String?
    
    var privacy: Privacy?
    
    var url: String?
    
    var createdAt: Date?
    
    var creator: User?

    var counts: Counts?
    
    var images: [Image]?
    
    // MARK: - Mappable
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        description     <- map["description"]
        privacy         <- (map["privacy"], EnumTransform<Privacy>())
        url             <- map["url"]
        createdAt       <- (map["created_at"], DateTransform())
        creator         <- map["creator"]
        counts          <- map["counts"]
        images          <- (map["image"], ImageTransformType())
    }
}
