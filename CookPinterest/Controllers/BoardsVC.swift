//
//  BoardsVC.swift
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

class BoardsVC: UIViewController, UICollectionViewDelegate, PinterestLayoutDelegate {

    // MARK: - IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Data
    
    let boardsResults = PublishSubject<[Boards]>()

    // MARK: - Rx
    
    let disposeBag = DisposeBag()
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

        loadDataSource()

        fetchBoards()
    }
    
    private func loadDataSource() {
        
        let layout = PinterestLayout()
        collectionView.collectionViewLayout = layout
        layout.delegate = self
        layout.cellPadding = 5
        layout.numberOfColumns = 2

        boardsResults.bind(to: collectionView.rx.items(cellIdentifier: "BoardsCell",
                                                              cellType: BoardsCell.self)) { (row, element, cell) in
                                    
                print("Element:", element)
        
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
