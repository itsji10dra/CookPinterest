//
//  Pins+Layout.swift
//  CookPinterest
//
//  Created by Jitendra on 15/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import PinterestLayout

extension PinsVC: PinterestLayoutDelegate {
    
    func configureLayout() {
        
        let layout = PinterestLayout()
        collectionView.collectionViewLayout = layout
        layout.delegate = self
        layout.cellPadding = 2
        layout.numberOfColumns = 2
    }

    // MARK: - PinterestLayoutDelegate

    func collectionView(collectionView: UICollectionView,
                        heightForImageAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        
        return defaultHeight
    }
    
    func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        
        return defaultHeight
    }
}
