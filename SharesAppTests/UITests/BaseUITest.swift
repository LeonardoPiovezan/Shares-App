//
//  BaseUITest.swift
//  SharesAppTests
//
//  Created by Leonardo Piovezan on 13/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import KIF
import Swinject

@testable import SharesApp

class BaseUITest: KIFTestCase {
    lazy var appDelegate: AppDelegate = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate
    }()

    lazy var defaultContainer: DefaultContainer = {
        return appDelegate.defaultContainer
    }()

    lazy var appCoordinator: Coordinator? = {
        return appDelegate.appCoordinator
    }()

    override func beforeAll() {
        super.beforeAll()
        self.configureContainer(container: self.defaultContainer.container)
    }

    override func beforeEach() {
        self.restartApplication()
    }

    func restartApplication() {
        self.appCoordinator?.start()
    }

    func configureContainer(container: Container){
        container.register(SharesRepository.self) { _ in
            let share = Share(name: "ABC", symbol: "$", value: 3.5)
            let shareResult = Result<Share>.success(share)

            let certificate = Certificate(certificateId: 1,
                                          numberOfShares: 100,
                                          issuedDate: "")
            let certificatesResult = Result<[Certificate]>.success([certificate])

            let sellResult = Result.success(true)
            return MockSharesRepository(shareResult: shareResult,
                                 certificatesResult: certificatesResult,
                                 sellResult: sellResult)
        }
    }
    
}
