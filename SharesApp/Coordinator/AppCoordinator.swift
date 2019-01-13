//
//  AppCoordinator.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 11/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit
import Swinject

class AppCoordinator: Coordinator {

    private let window: UIWindow
    private let container: Container
    private var navigationController: UINavigationController!
    init(window: UIWindow,
         container: Container) {
        self.window = window
        self.container = container
    }

    func start() {
        let sharesView = container.resolve(SharesView.self)!
        sharesView.delegate = self
        self.navigationController = SharesNavigationController(rootViewController: sharesView)
        self.window.rootViewController = self.navigationController
    }
}

extension AppCoordinator: SharesViewDelegate {
    func showSellView(certificate: Certificate) {
        let sellView = container.resolve(SellView.self)!
        sellView.certificate = certificate
        self.navigationController.pushViewController(sellView, animated: true)
    }
}
