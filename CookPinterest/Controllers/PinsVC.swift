//
//  PinsVC.swift
//  CookPinterest
//
//  Created by Jitendra on 11/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage
import PinterestLayout

class PinsVC: UIViewController, UICollectionViewDelegate, PinterestLayoutDelegate {

    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Data
    
    let pinsDataSource = PublishSubject<[Pins]>()
    
    // MARK: - Rx
    
    let disposeBag = DisposeBag()
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()
        bindDataSource()
        fetchPins()
    }
    
    private func configureLayout() {
        
        let layout = PinterestLayout()
        collectionView.collectionViewLayout = layout
        layout.delegate = self
        layout.cellPadding = 5
        layout.numberOfColumns = 2
    }
    
    private func bindDataSource() {
        
        pinsDataSource.bind(to: collectionView.rx.items(cellIdentifier: "PinsCell",
                                                        cellType: PinsCell.self)) { (row, element, cell) in
                                                                                                                
                                                        if let url = element.images?.first?.url {
                                                            cell.imageView.af_setImage(withURL: url)
                                                        }
                                                        
            }
            .disposed(by: disposeBag)
    }
    
    func collectionView(collectionView: UICollectionView,
                        heightForImageAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        
        return 100
    }
    
    func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        
        return 100
    }

}
