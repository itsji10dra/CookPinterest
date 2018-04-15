//
//  PinsDetailsVC.swift
//  CookPinterest
//
//  Created by Jitendra on 15/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit
import AlamofireImage
import BFRImageViewer

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
    
    internal var pinInfo: Pins?
    
    internal var suggestBoardAction: (() -> Void)?
    
    private var imageViewAnimator: BFRImageTransitionAnimator?

    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Pin Details"
        
        configureUI()
        prepareImageViewAnimator()
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
            imageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "big-placeholder"))
        }
    }
    
    private func prepareImageViewAnimator() {
        
        imageViewAnimator = BFRImageTransitionAnimator()
        imageViewAnimator?.animatedImageContainer = imageView
        imageViewAnimator?.imageOriginFrame = imageView.frame
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
    
    @IBAction func viewSwipeDownAction(_ sender: Any) {
    
        dismissVC()
    }
    
    @IBAction func imageTappedAction(_ sender: Any) {
        
        guard let image = imageView.image,
            let imageVC = BFRImageViewController(imageSource: [image]) else { return }
        
        imageViewAnimator?.animatedImage = image
        imageVC.transitioningDelegate = imageViewAnimator

        present(imageVC, animated: true)
    }
}
