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

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Data
    
    let boardsDataSource = PublishSubject<[Boards]>()

    // MARK: - Rx
    
    let disposeBag = DisposeBag()
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

        loadDataSource()

        fetchBoards()
    }
    
    private func loadDataSource() {
        
        boardsDataSource.bind(to: tableView.rx.items(cellIdentifier: "BoardsCell",
                                                     cellType: BoardsCell.self)) { (row, element, cell) in
                                    
                cell.titleLabel.text = element.name
                cell.descriptionLabel.text = element.description
                
                if let url = element.images?.first?.url {
                    cell.iconImageView.af_setImage(withURL: url)
                }
            }
            .disposed(by: disposeBag)
    }
}
