//
//  Resource.swift
//  CookPinterest
//
//  Created by Jitendra on 04/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

enum Resource: String {
    
    case oAuth = "/oauth/"
    
    case accessToken = "/oauth/token"
}

extension Resource {
    
    var parameters: [String:String] {
        switch self {
        case .oAuth:
            return ["response_type" : "token",
                    "client_id"     : Configuration.clientId,
                    "state"         : Configuration.status,
                    "scope"         : "read_public",
                    "redirect_uri"  : String(format: "pdk%@://", Configuration.clientId)]
            
        case .accessToken:
            return [:]
        }
    }
}
