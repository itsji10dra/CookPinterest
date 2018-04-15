//
//  ResourceAddition.swift
//  CookPinterest
//
//  Created by Jitendra on 14/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

struct ResourceAddition {
    
    // MARK: - Public
    
    static func getURL(for resource: Resource,
                       withResource resourceParameters: [String]? = nil,
                       appendingQuery queryParameters: [String]? = nil,
                       isAuthenticated: Bool = true) -> URL? {
        
        if isAuthenticated && TokenManager.accessToken == nil {
            return nil
        }
        
        var endPoint = resource.rawValue
        
        if let resourceParameters = resourceParameters {
            endPoint = replaceResourceParameters(for: resource, with: resourceParameters)
        }
        
        var urlComponents = URLComponents(string: Configuration.url + endPoint)
        let parameters = getQueryParameters(for: resource, appending: queryParameters)
        urlComponents?.queryItems = parameters?.map { return URLQueryItem(name: $0, value: $1) }
        return urlComponents?.url
    }
    
    // MARK: - Private
    
    static private func getQueryParameters(for resource: Resource,
                                           appending parameters: [String]? = nil) -> [String:String]? {
        
        guard parameters?.count ?? 0 == resource.queryParametersRequired else {
            fatalError("""
                Wrong number of Query parameters passed.
                Required: \(resource.queryParametersRequired), Receieved: \(parameters?.count ?? 0)")
                """)
        }
        
        switch resource {
            
        case .oAuth:
            return ["response_type" : "token",
                    "client_id"     : Configuration.clientId,
                    "state"         : Configuration.status,
                    "scope"         : Configuration.scope,
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
            
        case .searchUserBoards:
            guard let boardsParameters = getQueryParameters(for: .userBoards),
                    let searchQuery = parameters?.first else { return nil }
            
            let queryParameters = ["query" : searchQuery]
            let finalParameters = boardsParameters.merging(queryParameters) { (_, new) in new }
            
            return finalParameters
            
        case .searchUserPins:
            guard let usersParameters = getQueryParameters(for: .userPins),
                let searchQuery = parameters?.first else { return nil }

            let queryParameters = ["query" : searchQuery]
            let finalParameters = usersParameters.merging(queryParameters) { (_, new) in new }
            
            return finalParameters
            
        case .suggestedBoards:
            guard let boardsParameters = getQueryParameters(for: .userBoards),
                let searchQuery = parameters?.first else { return nil }
            
            let queryParameters = ["pin_id" : searchQuery]
            let finalParameters = boardsParameters.merging(queryParameters) { (_, new) in new }
            
            return finalParameters
            
        case .userFollowers:
            guard let accessToken = TokenManager.accessToken else { return nil }
            return ["access_token"  : accessToken]
        }
    }
    
    static private func replaceResourceParameters(for resource: Resource,
                                                  with parameters: [String]) -> String {
        
        let toReplaceCharacter = "<id>"
        
        var path = resource.rawValue
        
        let parametersRequired = path.components(separatedBy: toReplaceCharacter).count - 1
        let parametersReceived = parameters.count
        
        guard parametersRequired == parametersReceived else {
            fatalError("""
                Wrong number of Resource parameters passed.
                Required: \(parametersRequired), Receieved: \(parametersReceived)")
                """)
        }
        
        parameters.forEach { parameter in
            if let range = path.range(of: toReplaceCharacter) {
                path = path.replacingCharacters(in: range, with: parameter)
            }
        }
        
        return path
    }
}
