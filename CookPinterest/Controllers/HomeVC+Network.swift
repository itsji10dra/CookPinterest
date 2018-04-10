//
//  HomeVC+Network.swift
//  CookPinterest
//
//  Created by Jitendra on 11/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import RxSwift
import RxAlamofire
import SafariServices

extension HomeVC {
    
    func authenticateUser() {
        
        guard let url = ResourceAddition.getURL(for: .oAuth, isAuthenticated: false) else { return }
        
        let safariVC = SFSafariViewController(url: url)
        navigationController?.present(safariVC, animated: true, completion: nil)
    }
    
    func fetchUserDetails() {
        
        guard let url = ResourceAddition.getURL(for: .userInfo)?.absoluteString else { return }
        
        LoadingIndicator.startAnimating()
        
        RxAlamofire.requestJSON(.get, url)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_, json) in
                
                let userData = User.parse(json)
                self?.updateUserDataUI(with: userData)
                
                }, onError: { [weak self] error in
                    LoadingIndicator.stopAnimating()
                    self?.showNetworkErrorAlert(with: error.localizedDescription)
                }, onCompleted: {
                    LoadingIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func showNetworkErrorAlert(with message: String) {
        
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] action in
            self?.fetchUserDetails()
        }
        alertController.addAction(retryAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
