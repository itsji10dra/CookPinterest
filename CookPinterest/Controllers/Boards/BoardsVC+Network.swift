//
//  BoardsVC+Network.swift
//  CookPinterest
//
//  Created by Jitendra on 11/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import RxSwift
import RxAlamofire

extension BoardsVC {
    
    // MARK: - Internal
    
    internal func fetchUserBoards() {
    
        guard let url = ResourceAddition.getURL(for: .userBoards) else { return }

        fetchBoards(with: url)
    }
    
    internal func fetchUserBoards(with query: String) {
        
        guard let url = ResourceAddition.getURL(for: .searchUserBoards, appendingQuery: [query]) else { return }

        fetchBoards(with: url)
    }
    
    // MARK: - Private

    private func fetchBoards(with url: URL) {
        
        LoadingIndicator.startAnimating()
        
        RxAlamofire.requestJSON(.get, url)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_, json) in
                
                guard let boards = Boards.parse(json) else { return }
                self?.boardsDataSource.onNext(boards)
                
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
            self?.fetchUserBoards()
        }
        alertController.addAction(retryAction)
        
        let goBackAction = UIAlertAction(title: "Go Back", style: .cancel) { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(goBackAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
