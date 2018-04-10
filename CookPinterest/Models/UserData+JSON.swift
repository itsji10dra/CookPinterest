//
//  UserData+JSON.swift
//  CookPinterest
//
//  Created by Jitendra on 10/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

extension UserData {
    
    static func parse(_ json: Any) -> UserData? {

        guard let jsonDictionary = json as? [String: AnyObject],
            let dataInfo = jsonDictionary["data"] as? [String: AnyObject],
            let jsonText = ParsingHelper.getJSONString(dictionary: dataInfo),
            let userDataObj = Mapper<UserData>().map(JSONString: jsonText) else { return nil }
        
        return userDataObj
    }
}
