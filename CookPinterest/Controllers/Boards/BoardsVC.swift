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

class BoardsVC: UIViewController, UITableViewDelegate {

    // MARK: - IBOutlets

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Data
    
    let boardsDataSource = PublishSubject<[Boards]>()

    var pinId: String?

    // MARK: - Rx
    
    let disposeBag = DisposeBag()
    
    private let throttleTimeInterval = 1.0
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

        bindSearchModel()
        bindDataSource()
        configureModelSelection()
        fetchUserBoards()
    }
    
    private func bindSearchModel() {
        
        let searchWord: Driver<String>? = searchBar.rx.text.orEmpty.asDriver()
            .flatMapLatest { [weak self] in
                let invalidCharacter = CharacterSet.letters.union(.whitespaces).inverted
                let validInputText = $0.trimmingCharacters(in: invalidCharacter)
                self?.searchBar.text = validInputText
                    let shouldReset = validInputText.count < 1
                    if shouldReset == true {
                        self?.fetchUserBoards()
                    }
                return Driver.just(validInputText)
            }
            .distinctUntilChanged()
            .throttle(throttleTimeInterval)
        
        searchWord?.drive(onNext: { [weak self] searchText in
            self?.fetchUserBoards(with: searchText)
        }).disposed(by: self.disposeBag)
    }
    
    private func bindDataSource() {
        
        boardsDataSource.bind(to: tableView.rx.items(cellIdentifier: "BoardsCell",
                                                     cellType: BoardsCell.self)) { (row, element, cell) in
                                    
                cell.titleLabel.text = element.name
                cell.descriptionLabel.text = element.description
                
                if let url = element.images?.first?.url {
                    cell.iconImageView.af_setImage(withURL: url)
                } else {
                    cell.iconImageView.image = nil
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func configureModelSelection() {
        
        tableView.rx.modelSelected(Boards.self)
            .subscribe(onNext:  { [weak self] board in
                guard let boardId = board.id else { return }
                self?.pushPinsScene(with: boardId)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Navigation
    
    private func pushPinsScene(with boardId: String) {
        
        guard let pinsVC = Navigation.getViewController(type: PinsVC.self, identifer: "Pins") else { return }
        pinsVC.boardId = boardId
        navigationController?.pushViewController(pinsVC, animated: true)
    }
}
