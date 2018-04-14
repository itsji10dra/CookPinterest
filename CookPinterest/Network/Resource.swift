//
//  Resource.swift
//  CookPinterest
//
//  Created by Jitendra on 04/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

enum Resource: String {
    
    case oAuth              = "/oauth/"
    
    case userInfo           = "/v1/me/"
    
    case userBoards         = "/v1/me/boards/"

    case userPins           = "/v1/me/pins/"

    case searchUserBoards   = "/v1/me/search/boards/"
    
    case searchUserPins     = "/v1/me/search/pins/"

    case boardPins          = "/v1/boards/<id>/pins/"
    
    var queryParametersRequired: Int {
        switch self {
        case .searchUserBoards, .searchUserPins:
            return 2
        default:
            return 0
        }
    }
}
