//
//  HomeVC.swift
//  CookPinterest
//
//  Created by Jitendra on 04/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

class HomeVC: UIViewController {

    // MARK: - IBOutelts

    @IBOutlet weak var authenticateButton: UIButton!
    
    // MARK: - Rx
    
    let disposeBag = DisposeBag()
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let observableToken = Observable.just(TokenManager.accessToken)

        observableToken
            .debug()
            .map { $0 == nil }
            .bind(to: authenticateButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    // MARK: - Actions
    
    @IBAction func authenticateAction(_ sender: Any) {
        
        guard TokenManager.accessToken == nil else { return }

        let resource = Resource.oAuth
        var urlComponents = URLComponents(string: Configuration.url + resource.rawValue)
        urlComponents?.queryItems = resource.parameters.map { return URLQueryItem(name: $0, value: $1) }

        guard let url = urlComponents?.url else { return }
        
        let safariVC = SFSafariViewController(url: url)
        navigationController?.present(safariVC, animated: true, completion: nil)
    }
}
