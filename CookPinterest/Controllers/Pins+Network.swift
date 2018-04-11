//
//  Pins+Network.swift
//  CookPinterest
//
//  Created by Jitendra on 11/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import RxSwift
import RxAlamofire

extension PinsVC {
    
    func fetchPins() {

        guard let url = ResourceAddition.getURL(for: .userPins) else { return }
        
        LoadingIndicator.startAnimating()
        
        RxAlamofire.requestJSON(.get, url)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_, json) in
                
                guard let pins = Pins.parse(json) else { return }
                self?.pinsDataSource.onNext(pins)
                
                }, onError: { [weak self] error in
                    LoadingIndicator.stopAnimating()
//                    self?.showNetworkErrorAlert(with: error.localizedDescription)
                }, onCompleted: {
                    LoadingIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
    }
}
