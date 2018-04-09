//
//  KeychainManager.swift
//  CookPinterest
//
//  Created by Jitendra on 09/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import SwiftKeychainWrapper

internal struct KeychainManager {
    
    // MARK: - Private
    
    static private let kAccessTokenKey = "CookPinterestAccessToken"
    
    static private(set) var accessToken: String? = nil
    
    // MARK: - Internal
    
    @discardableResult
    static internal func save(_ token: String) -> Bool {
        let status = KeychainWrapper.standard.set(token, forKey: kAccessTokenKey)
        if status == true {
            self.accessToken = token
        }
        return status
    }
    
    @discardableResult
    static internal func clear() -> Bool {
        let status = KeychainWrapper.standard.removeObject(forKey: kAccessTokenKey)
        if status == true {
            self.accessToken = nil
        }
        return status
    }
}
