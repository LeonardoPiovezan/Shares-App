//
//  DefaultContainer.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 11/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import Swinject

final class DefaultContainer {
    let container: Container

    init() {
        self.container = Container()
        self.registerServices()
        self.registerRepositories()
        self.registerViews()
    }
}
