//
//  TokenManager.swift
//  CookPinterest
//
//  Created by Jitendra on 09/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import SwiftKeychainWrapper

internal struct TokenManager {
    
    // MARK: - Internal
    
    static internal let kAccessTokenKey = "CookPinterestAccessToken"

    // MARK: - Private
    
    static private(set) var accessToken: String? = nil {
        didSet {
            NotificationCenter.default.post(name: Notification.Name(kAccessTokenKey), object: nil)
        }
    }
    
    // MARK: - Internal Methods
    
    static internal func restore() {
        guard let token = KeychainWrapper.standard.string(forKey: kAccessTokenKey) else { return }
        self.accessToken = token
    }
    
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
