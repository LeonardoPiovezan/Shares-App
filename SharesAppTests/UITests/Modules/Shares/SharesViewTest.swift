//
//  SharesViewTest.swift
//  SharesAppTests
//
//  Created by Leonardo Piovezan on 13/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation

@testable import SharesApp

class SharesViewTest: BaseUITest {

    func testNavigationToSellView() {
        expectToSeeSharesView()
        tapOnTableCell()
        tester().waitForAnimationsToFinish()
        expectToSeeSellView()
    }

    func testFlowOfSellShares() {
        expectToSeeSharesView()
        tapOnTableCell()
        tester().waitForAnimationsToFinish()
        expectToSeeSellView()

        insertNuberOfShares(shares: "50")
        expectSellButtonEnable()

        insertNuberOfShares(shares: "10000000")
        expectSellButtonDisable()

        insertNuberOfShares(shares: "70")
        expectSellButtonEnable()

        tapOnSellButton()
        tapOnNo()
        expectToSeeSellView()

        tapOnSellButton()
        tapOnYes()
        tester().waitForAnimationsToFinish()
        tapOnOk()
        expectToSeeSharesView()

    }
}
