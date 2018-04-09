//
//  AppDelegate+Methods.swift
//  CookPinterest
//
//  Created by Jitendra on 09/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    internal func  isValid(_ url: URL) -> Bool {
        
        //Confirming call is from Safari on login success
        guard url.scheme?.contains(Configuration.clientId) == true else { return false }
        
        //Let's grab received query parameters
        let params = url.query?.components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce(into: [String:String]()) { dict, pair in
                if pair.count == 2 {
                    dict[pair[0]] = pair[1]
                }
        }
        
        guard let parameters = params else { return false }
        
        //Okay, spoof check like Pro
        guard parameters["status"] != Configuration.status else { return false }
        
        //Everything good, here's our access token
        guard let accessToken = parameters["access_token"] else { return false }
        
        dismissSafariViewControllerIfAny()
        
        //Save it, for future use.
        return KeychainManager.save(accessToken)
    }
    
    internal func dismissSafariViewControllerIfAny() {
     
        guard let safariVC = window?.rootViewController?.presentedViewController else { return }
        
        safariVC.dismiss(animated: true, completion: nil)
    }
}
