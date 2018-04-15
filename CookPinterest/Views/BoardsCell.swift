//
//  BoardsCell.swift
//  CookPinterest
//
//  Created by Jitendra on 11/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

class BoardsCell: UITableViewCell {
    
    // MARK: - IBOutelts

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!    
    
    // MARK: - View

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        accessoryType = BoardsVC.accessoryType
        clearSelectedBackgroundView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func clearSelectedBackgroundView() {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        backgroundView = view
    }
}
