//
//  CircularProgressView.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 13/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import RPCircularProgress

class CircularProgressView: RPCircularProgress {

    required init() {
        super.init()
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    func setup() {
        self.thicknessRatio = 0.1
        self.indeterminateDuration = 0.7
        self.indeterminateProgress = 0.3
        self.trackTintColor = UIColor.white
        self.progressTintColor = UIColor.darkGray
        self.enableIndeterminate()
    }
}
