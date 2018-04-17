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
                Steps to fix:
                    - Replace `clientId` as received from developers.pinterest.com.
                    - Update Info.plist > URL Scheme > `pkd` + `clientId`.
                        - Say your clientId is `6253638936`, your URL scheme will be `pkd6253638936`.
                Also, define your `scope`.
            """)
        }
    }
}
