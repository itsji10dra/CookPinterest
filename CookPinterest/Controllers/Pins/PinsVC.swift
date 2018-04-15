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

class PinsVC: UIViewController, UICollectionViewDelegate {

    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Data
    
    var boardId: String?
    
    let pinsDataSource = PublishSubject<[Pins]>()
    
    // MARK: - Rx
    
    let disposeBag = DisposeBag()
    
    private let throttleTimeInterval = 1.0
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureLayout()
        bindDataSource()
        bindSearchModel()
        configureModelSelection()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        
        let hasBoardId = boardId != nil
        
        if hasBoardId {         //Search not allowed if showing pins from specific board.
            searchBar.removeFromSuperview()
        }
    }
    
    private func bindSearchModel() {
        
        let searchWord: Driver<String>? = searchBar.rx.text.orEmpty.asDriver()
            .flatMapLatest { [weak self] in
                let invalidCharacter = CharacterSet.letters.union(.whitespaces).inverted
                let validInputText = $0.trimmingCharacters(in: invalidCharacter)
                self?.searchBar.text = validInputText
                let shouldReset = validInputText.count < 1
                if shouldReset == true {
                    self?.fetchDefaultPins()
                }
                return Driver.just(validInputText)
            }
            .distinctUntilChanged()
            .throttle(throttleTimeInterval)
        
        searchWord?.drive(onNext: { [weak self] searchText in
            self?.fetchUserPins(with: searchText)
        }).disposed(by: self.disposeBag)
    }

    private func bindDataSource() {
        
        pinsDataSource.bind(to: collectionView.rx.items(cellIdentifier: "PinsCell",
                                                        cellType: PinsCell.self)) { (row, element, cell) in
                                 
                cell.titleLabel.text = element.note
                                                            
                if let color = element.color {
                    cell.backgroundColor = UIColor.colorWithHex(color)
                }
                                                            
                if let url = element.images?.first?.url {
                    cell.imageView.af_setImage(withURL: url)
                } else {
                    cell.imageView.image = nil
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func configureModelSelection() {
        
        collectionView.rx.modelSelected(Pins.self)
            .subscribe(onNext: { [weak self] pin in
                self?.showPinsDetailsScene(for: pin)
            })
            .disposed(by: disposeBag)
    }

    private func fetchDefaultPins() {
        
        if let boardId = boardId {
            fetchUserPins(for: boardId)
        } else {
            fetchUserPins()
        }
    }
}
