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
    
    @IBOutlet weak var createdByLabel: UILabel!
    
    @IBOutlet weak var createdTimeLabel: UILabel!

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
        createdByLabel.text = pinInfo.creator?.firstName
        createdTimeLabel.text = Date.string(from: pinInfo.createdAt, format: Date.Format.d_space_MMM_comma_space_EEE)
        
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
