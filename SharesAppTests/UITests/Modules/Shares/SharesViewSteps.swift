//
//  SharesViewSteps.swift
//  SharesAppTests
//
//  Created by Leonardo Piovezan on 13/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import UIKit
import Nimble

@testable import SharesApp

extension SharesViewTest {
    func expectToSeeSharesView() {
        tester().waitForView(withAccessibilityLabel: "sharesView")
    }

    func expectNotToSeeSharesView() {
        expectToSee("sharesView")
    }

    func expectToSeeSellView() {
        tester().waitForView(withAccessibilityLabel: "sellView")
    }

    func expectSellButtonEnable() {
        let button = getView("sellButton") as! StateButton
        expect(button.isEnabled) == true
    }

    func expectSellButtonDisable() {
        let button = getView("sellButton") as! StateButton
        expect(button.isEnabled) == false
    }

    func expectToSeeVerificationAlert() {
        expectToSee("verificationAlert")
    }
}

extension SharesViewTest {

    func tapOnTableCell() {
        let table = getView("sharesTable") as! UITableView
        tapOnTableViewCell(indexPath: IndexPath(row: 0, section: 0), tableView: table)
    }

    func insertNuberOfShares(shares: String){
        insertText(shares, label: "sharesToSell")
    }

    func tapOnSellButton() {
        tapOnView("sellButton")
    }

    func tapOnYes() {
        tapOnView("Yes")
    }

    func tapOnNo() {
        tapOnView("No")
    }

    func tapOnOk() {
        tapOnView("OK")
    }
}
