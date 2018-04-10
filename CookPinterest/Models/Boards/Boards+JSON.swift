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
        
        var boards: [Boards] = []
        
        guard let jsonDictionary = json as? [String: AnyObject],
            let dataInfoArray = jsonDictionary["data"] as? [[String: AnyObject]] else { return nil }
        
        dataInfoArray.forEach { dataInfo in
            if let jsonText = ParsingHelper.getJSONString(dictionary: dataInfo),
                let board = Mapper<Boards>().map(JSONString: jsonText) {
                boards.append(board)
            }
        }

        return boards
    }
}
