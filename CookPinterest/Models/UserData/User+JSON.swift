//
//  User+JSON.swift
//  CookPinterest
//
//  Created by Jitendra on 10/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

extension User {
    
    static func parse(_ json: Any) -> User? {

        guard let jsonDictionary = json as? [String: AnyObject],
            let dataInfo = jsonDictionary["data"] as? [String: AnyObject],
            let jsonText = ParsingHelper.getJSONString(dictionary: dataInfo),
            let userDataObj = Mapper<User>().map(JSONString: jsonText) else { return nil }
        
        return userDataObj
    }
}
