//
//  Pins.swift
//  CookPinterest
//
//  Created by Jitendra on 11/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

struct Pins: Mappable {
    
    private(set) var id: String?
    
    var note: String?

    var url: String?

    var creator: User?

    var createdAt: Date?

    var color: String?

    var board: Boards?

    var counts: Counts?
    
    var images: [Image]?

    // MARK: - Mappable
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id              <- map["id"]
        note            <- map["note"]
        url             <- map["url"]
        creator         <- map["creator"]
        createdAt       <- (map["created_at"], DateTransform())
        color           <- map["color"]
        board           <- map["board"]
        counts          <- map["counts"]
        images          <- (map["image"], ImageTransformType())
    }
}
