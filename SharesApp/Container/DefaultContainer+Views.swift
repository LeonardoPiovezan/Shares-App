//
//  DefaultContainer+Views.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 11/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

extension DefaultContainer {
    func registerViews() {
        container.register(SharesView.self) { resolver in
            let repository = resolver.resolve(SharesRepository.self)!
            return SharesView(repository: repository)
        }

        container.register(SellView.self) { resolver in
            let repository = resolver.resolve(SharesRepository.self)!
            return SellView(repository: repository)
        }
    }
}
