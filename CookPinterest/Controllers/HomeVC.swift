//
//  HomeVC.swift
//  CookPinterest
//
//  Created by Jitendra on 04/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: UIViewController {

    // MARK: - IBOutelts

    @IBOutlet private weak var authenticateButton: UIButton!
    
    @IBOutlet private weak var signOutButton: UIButton!

    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: - Rx
    
    let disposeBag = DisposeBag()
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeToken()
        configureUI()
        fetchUserDetails()
    }

    // MARK: - Notification

    private func observeToken() {
        
        NotificationCenter.default.rx.notification(Notification.Name(TokenManager.kAccessTokenKey))
            .subscribe { [weak self] _ in
                self?.configureUI()
                self?.fetchUserDetails()
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - UI

    private func configureUI() {
        
        let hasToken = TokenManager.accessToken != nil
        authenticateButton.isEnabled = !hasToken
        signOutButton.isEnabled = hasToken
    }
    
    func updateUserDataUI(with data: User?) {
        
        var fullName: String?
        
        defer { nameLabel.text = fullName }
        
        guard let firstName = data?.firstName,
            let lastName = data?.lastName else { return }
         
        fullName = firstName + " " + lastName
    }

    // MARK: - Actions
    
    @IBAction func authenticateAction(_ sender: Any) {

        authenticateUser()
    }
    
    @IBAction func viewBoardsAction(_ sender: Any) {
    
        pushBoardsScene()
    }
    
    @IBAction func signOutAction(_ sender: Any) {
        
        TokenManager.clear()
        updateUserDataUI(with: nil)
    }
    
    // MARK: - Navigation
    
    private func pushBoardsScene() {
        
        guard let boardsVC = Navigation.getViewController(type: BoardsVC.self, identifer: "Boards") else { return }
        navigationController?.pushViewController(boardsVC, animated: true)
    }
}
