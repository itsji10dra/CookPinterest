//
//  HomeVC.swift
//  CookPinterest
//
//  Created by Jitendra on 04/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit
import SafariServices

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Actions
    
    @IBAction func authenticateAction(_ sender: Any) {
        
        let resource = Resource.oAuth
        var urlComponents = URLComponents(string: Configuration.url + resource.rawValue)
        urlComponents?.queryItems = resource.parameters.map { return URLQueryItem(name: $0, value: $1) }

        guard let url = urlComponents?.url else { return }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
}
