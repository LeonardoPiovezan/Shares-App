//
//  SharesServiceImpl.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 11/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import RxSwift
import Moya

final class SharesServiceImpl: SharesService {
    let provider: MoyaProvider<SharesRouter>

    init(provider: MoyaProvider<SharesRouter>) {
        self.provider = provider
    }

    func getCertificateList() -> Single<Response> {
        return self.provider.rx.request(.certificatesList)
    }

    func getCurrentSharePrice() -> Single<Response> {
        return self.provider.rx.request(.currentSharePrice)
    }

    func postSellCertificates(_ certificates: [Certificate]) -> Single<Response> {
        return self.provider.rx.request(.sellCertificates(certificates: certificates))
    }
}
