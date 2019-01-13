//
//  CommonSteps.swift
//  SharesAppTests
//
//  Created by Leonardo Piovezan on 13/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import UIKit

@testable import SharesApp

extension BaseUITest {

    func expectToSee(_ accessibilityLabel: String) {
        tester().waitForView(withAccessibilityLabel: accessibilityLabel)
    }

    func expectNotToSee(_ accessibilityLabel: String) {
        tester().waitForAbsenceOfView(withAccessibilityLabel: accessibilityLabel)
    }

    func tapOnView(_ accessibilityLabel: String) {
        tester().tapView(withAccessibilityLabel: accessibilityLabel)
    }

    func getView(_ accessibilityLabel:String) -> UIView {
        return tester().waitForView(withAccessibilityLabel: accessibilityLabel)
    }

    func tapOnTableViewCell(indexPath: IndexPath, tableView: UITableView) {
        tester().tapRow(at: indexPath, in: tableView)
    }

    func insertText( _ text: String, label: String) {
        tester().clearText(fromAndThenEnterText: text, intoViewWithAccessibilityLabel: label)
    }
}
