//
//  Pins+JSON.swift
//  CookPinterest
//
//  Created by Jitendra on 12/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

extension Pins {
    
    static func parse(_ json: Any) -> [Pins]? {
        
        guard let jsonDictionary = json as? [String: AnyObject],
            let dataInfoArray = jsonDictionary["data"] as? [[String: AnyObject]] else { return nil }
        
        let pins = dataInfoArray.compactMap { return Pins(JSON: $0) }
        
        return pins
    }
}
