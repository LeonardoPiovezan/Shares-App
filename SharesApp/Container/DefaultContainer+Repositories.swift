//
//  DefaultContainer+Repositories.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 11/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

extension DefaultContainer {
    func registerRepositories() {
        self.container.register(SharesRepository.self) { resolver in
            let service = resolver.resolve(SharesService.self)!
            return SharesRepositoryImpl(service: service)
        }
    }
}
