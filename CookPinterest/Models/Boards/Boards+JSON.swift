//
//  Boards+JSON.swift
//  CookPinterest
//
//  Created by Jitendra on 11/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

extension Boards {
    
    static func parse(_ json: Any) -> [Boards]? {
        
        guard let jsonDictionary = json as? [String: AnyObject],
            let dataInfoArray = jsonDictionary["data"] as? [[String: AnyObject]] else { return nil }
        
        let boards = dataInfoArray.compactMap { return Boards(JSON: $0) }

        return boards
    }
}
