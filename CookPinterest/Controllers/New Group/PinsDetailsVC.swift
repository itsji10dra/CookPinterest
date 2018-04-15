//
//  PinsDetailsVC.swift
//  CookPinterest
//
//  Created by Jitendra on 15/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit
import AlamofireImage

class PinsDetailsVC: UIViewController {

    // MARK: - IBOutelts
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var noteLabel: UILabel!
    
    @IBOutlet private weak var boardNameLabel: UILabel!

    @IBOutlet private weak var createdByLabel: UILabel!
    
    @IBOutlet private weak var createdTimeLabel: UILabel!

    @IBOutlet private weak var commentsCountLabel: UILabel!

    @IBOutlet private weak var saveCountLabel: UILabel!

    // MARK: - Data
    
    var pinInfo: Pins?
    
    var suggestBoardAction: (() -> Void)?

    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Pin Details"
        
        configureUI()
    }
    
    private func configureUI() {
        
        guard let pinInfo = pinInfo else { return }
        
        noteLabel.text = pinInfo.note
        boardNameLabel.text = pinInfo.board?.name

        let firstName = pinInfo.creator?.firstName ?? ""
        let lastName = pinInfo.creator?.lastName ?? ""
        createdByLabel.text = firstName + " " + lastName
        
        createdTimeLabel.text = Date.string(from: pinInfo.createdAt, format: .dd_space_MMM_space_YYYY_HH_colon_mm)
        commentsCountLabel.text = String(pinInfo.counts?.comments ?? 0)
        saveCountLabel.text = String(pinInfo.counts?.saves ?? 0)
        
        if let color = pinInfo.color {
            imageView.backgroundColor = UIColor.colorWithHex(color)
        }
        
        if let url = pinInfo.images?.first?.url {
            imageView.af_setImage(withURL: url)
        }
    }
    
    // MARK: - Internal
    
    @objc
    internal func dismissVC() {
        dismiss(animated: true)
    }
    
    // MARK: - Action
    
    @IBAction func suggestBoardsAction(_ sender: Any) {
        
        dismiss(animated: true) { [weak self] in
            self?.suggestBoardAction?()
        }
    }
}
