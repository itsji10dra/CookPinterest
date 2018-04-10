//
//  Resource.swift
//  CookPinterest
//
//  Created by Jitendra on 04/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

enum Resource: String {
    
    case oAuth = "/oauth/"
    
    case userInfo = "/v1/me/"
    
    case userBoards = "/v1/me/boards/"

    case userPins = "/v1/me/pins/"
}

struct ResourceAddition {
    
    static func getParameters(for resource: Resource) -> [String:String]?  {
        
        switch resource {
        case .oAuth:
            return ["response_type" : "token",
                    "client_id"     : Configuration.clientId,
                    "state"         : Configuration.status,
                    "scope"         : "read_public",
                    "redirect_uri"  : String(format: "pdk%@://", Configuration.clientId)]
            
        case .userInfo:
            guard let accessToken = TokenManager.accessToken else { return nil }
            return ["access_token"  : accessToken]
            
        case .userBoards:
            guard let accessToken = TokenManager.accessToken else { return nil }
            return ["access_token"  : accessToken]
            
        case .userPins:
            guard let accessToken = TokenManager.accessToken else { return nil }
            return ["access_token"  : accessToken]

        }
    }
    
    static func getURL(for resource: Resource, isAuthenticated: Bool = true) -> URL?  {
        
        if isAuthenticated &&
            TokenManager.accessToken == nil {
            return nil
        }
        
        var urlComponents = URLComponents(string: Configuration.url + resource.rawValue)
        let parameters = ResourceAddition.getParameters(for: resource)
        urlComponents?.queryItems = parameters?.map { return URLQueryItem(name: $0, value: $1) }
        return urlComponents?.url
    }
}
