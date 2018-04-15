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
    
    @IBOutlet private weak var greetingLabel: UILabel!

    @IBOutlet private weak var featuresStackView: UIStackView!
    
    @IBOutlet private weak var signOutButton: UIButton!
    
    // MARK: - Rx
    
    internal let disposeBag = DisposeBag()
    
    private let defaultText = "Kindly authenticate yourself."
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeToken()
        configureControlsUI()
        fetchUserDetails()
    }

    // MARK: - Notification

    private func observeToken() {
        
        NotificationCenter.default.rx.notification(Notification.Name(TokenManager.kAccessTokenKey))
            .subscribe { [weak self] _ in
                self?.configureControlsUI()
                self?.fetchUserDetails()
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - UI

    private func configureControlsUI() {
        
        let hasToken = TokenManager.accessToken != nil
        authenticateButton.isHidden = hasToken
        signOutButton.isHidden = !hasToken
        featuresStackView.isHidden = !hasToken
    }
    
    func updateUserDataUI(with data: User?) {
        
        var fullName: String?
        
        defer {
            var text = defaultText
            if let name = fullName {
                let greeting = "Welcome: "
                text = greeting + name
            }
            greetingLabel.text = text
        }
        
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
    
    @IBAction func viewPinsAction(_ sender: Any) {
    
        pushPinsScene()
    }
    
    @IBAction func viewFollowedBoardsAction(_ sender: Any) {
    
        pushBoardsScene(showingSelfData: false)
    }
    
    @IBAction func signOutAction(_ sender: Any) {
        
        TokenManager.clear()
        updateUserDataUI(with: nil)
    }
    
    // MARK: - Navigation
    
    private func pushBoardsScene(showingSelfData: Bool = true) {
        
        guard let boardsVC = Navigation.getViewController(type: BoardsVC.self, identifer: "Boards") else { return }
        boardsVC.showingBoardsFromOtherUser = !showingSelfData
        navigationController?.pushViewController(boardsVC, animated: true)
    }
    
    private func pushPinsScene() {

        guard let pinsVC = Navigation.getViewController(type: PinsVC.self, identifer: "Pins") else { return }
        navigationController?.pushViewController(pinsVC, animated: true)
    }
}
