//
//  NetworkManager.swift
//  CookPinterest
//
//  Created by Jitendra on 15/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import RxSwift
import RxAlamofire

struct NetworkManager {
    
    static func getRequest(with url: URL) -> Observable<(HTTPURLResponse, Any)> {
        
        return RxAlamofire.requestJSON(.get, url)
            .observeOn(MainScheduler.instance)
    }
}
