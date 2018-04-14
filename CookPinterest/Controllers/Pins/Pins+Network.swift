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
    
    func fetchPins(for boardId: String? = nil) {

        //If boardId is received, it will pull Pins for specific board, or else all Pins for logged in user.
        
        let hasBoardId = boardId != nil
        let resourcePath: Resource = hasBoardId ? .boardPins : .userPins
        let parameters: [String]? = hasBoardId ? [boardId!] : nil
        
        guard let url = ResourceAddition.getURL(for: resourcePath, withResource: parameters) else { return }
        
        LoadingIndicator.startAnimating()
        
        RxAlamofire.requestJSON(.get, url)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_, json) in
                
                guard let pins = Pins.parse(json) else { return }
                self?.pinsDataSource.onNext(pins)
                
                }, onError: { [weak self] error in
                    LoadingIndicator.stopAnimating()
                    self?.showNetworkErrorAlert(with: error.localizedDescription)
                }, onCompleted: {
                    LoadingIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
    }
    
    private func showNetworkErrorAlert(with message: String) {
        
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] action in
            self?.fetchPins()
        }
        alertController.addAction(retryAction)
        
        let goBackAction = UIAlertAction(title: "Go Back", style: .cancel) { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(goBackAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
