//
//  SharesNavigationController.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 13/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

class SharesNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigaton()
        // Do any additional setup after loading the view.
    }
    
    func setupNavigaton() {
        self.navigationBar.barTintColor = .mainBlue
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = .white
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: Constants.Font.helveticaNeue, size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
}
