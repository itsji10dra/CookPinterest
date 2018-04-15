//
//  Pins+Navigation.swift
//  CookPinterest
//
//  Created by Jitendra on 15/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

extension PinsVC {
    
    func showPinsDetailsScene(for pin: Pins) {
        
        guard let pinsDetailsVC = Navigation.getViewController(type: PinsDetailsVC.self, identifer: "PinsDetails") else { return }
        pinsDetailsVC.pinInfo = pin
        pinsDetailsVC.suggestBoardAction = { [weak self] in
            guard let pinId = pin.id else { return }
            self?.pushBoardSuggestionScene(for: pinId)
        }
        
        let navController = UINavigationController(rootViewController: pinsDetailsVC)
        
        let closeBarBtn = UIBarButtonItem(title: "Close", style: .plain, target: pinsDetailsVC, action: #selector(PinsDetailsVC.dismissVC))
        pinsDetailsVC.navigationItem.rightBarButtonItem = closeBarBtn
        
        navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func pushBoardSuggestionScene(for pinId: String) {
        
        guard let boardsVC = Navigation.getViewController(type: BoardsVC.self, identifer: "Boards") else { return }
        boardsVC.pinId = pinId
        navigationController?.pushViewController(boardsVC, animated: true)
    }
}
