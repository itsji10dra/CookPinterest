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

    // MARK: - Rx
    
    let disposeBag = DisposeBag()
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

        loadDataSource()

        configureModelSelection()

        fetchBoards()
    }
    
    private func loadDataSource() {
        
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
