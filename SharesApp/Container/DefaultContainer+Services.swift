//
//  DefaultContainer+Services.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 11/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//
import Moya

extension DefaultContainer {
    func registerServices() {
        self.container.register(SharesService.self) { _ in
            let provider = MoyaProvider<SharesRouter>()
            return SharesServiceImpl(provider: provider)
        }
    }
}
