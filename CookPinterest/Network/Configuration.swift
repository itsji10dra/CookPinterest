//
//  Configuration.swift
//  CookPinterest
//
//  Created by Jitendra on 04/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

struct Configuration {
        
    static let url          = "https://api.pinterest.com"
    
    static let clientId     = ""
    
    static let scope        = "read_public,read_relationships"
    
    static let status       = "XyjSoa42793PkeGuwnUb87h"       //Used in Authentication API, just a random string.
    
    static func checkConfiguration() {
        
        if clientId.isEmpty || scope.isEmpty {
            fatalError("""
                Invalid configuration found.
                Replace `clientId` as received from developers.pinterest.com.
                Also, define your `scope`.
            """)
        }
    }
}
