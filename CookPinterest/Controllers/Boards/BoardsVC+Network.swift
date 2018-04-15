//
//  BoardsVC+Network.swift
//  CookPinterest
//
//  Created by Jitendra on 11/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

extension BoardsVC {
    
    // MARK: - Internal
    
    internal func fetchUserBoards() {
    
        guard let url = ResourceAddition.getURL(for: .userBoards) else { return }

        fetchBoards(with: url)
    }
    
    internal func fetchUserSuggestedBoards(for pinId: String) {
        
        guard let url = ResourceAddition.getURL(for: .suggestedBoards, appendingQuery: [pinId]) else { return }
        
        fetchBoards(with: url)
    }
    
    internal func fetchUserBoards(with query: String) {
        
        guard let url = ResourceAddition.getURL(for: .searchUserBoards, appendingQuery: [query]) else { return }

        fetchBoards(with: url)
    }
    
    internal func fetchFollowingBoards() {
        
        guard let url = ResourceAddition.getURL(for: .followingBoards) else { return }
        
        fetchBoards(with: url)
    }

    // MARK: - Private

    private func fetchBoards(with url: URL) {
        
        LoadingIndicator.startAnimating()
        
        let observable = NetworkManager.getRequest(with: url)

        observable.subscribe(onNext: { [weak self] (_, json) in
                
                guard let boards = Boards.parse(json) else { return }
                self?.boardsDataSource.onNext(boards)
                
                }, onError: { [weak self] error in
                    LoadingIndicator.stopAnimating()
                    self?.showNetworkErrorAlert(with: error.localizedDescription, retryAction: {
                        self?.fetchBoards(with: url)
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
