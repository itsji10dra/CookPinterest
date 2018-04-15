//
//  Pins+Network.swift
//  CookPinterest
//
//  Created by Jitendra on 11/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

extension PinsVC {
    
    // MARK: - Internal

    internal func fetchUserPins() {

        guard let url = ResourceAddition.getURL(for: .userPins) else { return }

        fetchPins(with: url)
    }
    
    internal func fetchUserPins(for boardId: String) {
        
        guard let url = ResourceAddition.getURL(for: .boardPins, withResource: [boardId]) else { return }
        
        fetchPins(with: url)
    }
    
    internal func fetchUserPins(with query: String) {
        
        guard let url = ResourceAddition.getURL(for: .searchUserPins, appendingQuery: [query]) else { return }
        
        fetchPins(with: url)
    }
    
    // MARK: - Private
    
    private func fetchPins(with url: URL) {

        LoadingIndicator.startAnimating()
        
        let observable = NetworkManager.getRequest(with: url)

        observable.subscribe(onNext: { [weak self] (_, json) in
                
                guard let pins = Pins.parse(json) else { return }
                self?.pinsDataSource.onNext(pins)
                
                }, onError: { [weak self] error in
                    LoadingIndicator.stopAnimating()
                    self?.showNetworkErrorAlert(with: error.localizedDescription, retryAction: {
                        self?.fetchPins(with: url)
                    })
                }, onCompleted: {
                    LoadingIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
    }
    
    private func showNetworkErrorAlert(with message: String, retryAction: @escaping (() -> Void)) {

        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            retryAction()
        }
        alertController.addAction(retryAction)
        
        let goBackAction = UIAlertAction(title: "Go Back", style: .cancel) { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(goBackAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
