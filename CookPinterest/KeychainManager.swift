//
//  KeychainManager.swift
//  CookPinterest
//
//  Created by Jitendra on 09/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import SwiftKeychainWrapper

internal struct KeychainManager {
    
    static private let kAccessTokenKey = "CookPinterestAccessToken"
    
    static var accessToken: String? {
        return KeychainWrapper.standard.string(forKey: kAccessTokenKey)
    }
    
    @discardableResult
    static internal func save(_ token: String) -> Bool {
        return KeychainWrapper.standard.set(token, forKey: kAccessTokenKey)
    }
    
    @discardableResult
    static internal func clear() -> Bool {
        return KeychainWrapper.standard.removeObject(forKey: kAccessTokenKey)
    }
}
