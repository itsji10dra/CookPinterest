//
//  PinsCell.swift
//  CookPinterest
//
//  Created by Jitendra on 11/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

class PinsCell: UICollectionViewCell {
    
    // MARK: - IBOutlets

    @IBOutlet weak var imageHolderView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - View

    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        imageView.image = #imageLiteral(resourceName: "placeholder")
    }
}
