//
//  Resource.swift
//  CookPinterest
//
//  Created by Jitendra on 04/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

enum Resource: String {
    
    case oAuth      = "/oauth/"
    
    case userInfo   = "/v1/me/"
    
    case userBoards = "/v1/me/boards/"

    case userPins   = "/v1/me/pins/"
    
    case boardPins  = "/v1/boards/<id>/pins/"
}

struct ResourceAddition {
    
    // MARK: - Public

    static func getURL(for resource: Resource, appending parameters: [String]? = nil, isAuthenticated: Bool = true) -> URL?  {
        
        if isAuthenticated &&
            TokenManager.accessToken == nil {
            return nil
        }

        var endPoint = resource.rawValue
        
        if let parameters = parameters {
            endPoint = replace(resource.rawValue, with: parameters)
        }
        
        var urlComponents = URLComponents(string: Configuration.url + endPoint)
        let parameters = ResourceAddition.getQueryParameters(for: resource)
        urlComponents?.queryItems = parameters?.map { return URLQueryItem(name: $0, value: $1) }
        return urlComponents?.url
    }

    // MARK: - Private

    static private func getQueryParameters(for resource: Resource) -> [String:String]?  {
        
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
            return ["access_token"  : accessToken,
                    "fields"        : "id,name,url,image,description,privacy,counts,created_at,creator"]
            
        case .userPins, .boardPins:
            guard let accessToken = TokenManager.accessToken else { return nil }
            return ["access_token"  : accessToken,
                    "fields"        : "id,note,url,image,board,color,counts,created_at,creator"]

        }
    }
    
    static private func replace(_ source: String, with parameters: [String]) -> String {
        
        let toReplaceCharacter = "<id>"
        
        var path = source
        
        let parametersRequired = source.components(separatedBy: toReplaceCharacter).count - 1
        let parametersReceived = parameters.count
        
        guard parametersRequired == parametersReceived else {
            fatalError("Wrong number of parameters passed. Required: \(parametersRequired), Receieved: \(parametersReceived)")
        }
        
        parameters.forEach { parameter in
            if let range = path.range(of: toReplaceCharacter) {
                path = path.replacingCharacters(in: range, with: parameter)
            }
        }
        
        return path
    }
}
