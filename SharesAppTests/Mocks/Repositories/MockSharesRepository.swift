//
//  MockSharesRepository.swift
//  SharesAppTests
//
//  Created by Leonardo Piovezan on 12/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import RxSwift

@testable import SharesApp

class MockSharesRepository: SharesRepository {
    var shareResult: Result<Share>
    var certificatesResult: Result<[Certificate]>
    var sellResult: Result<Bool>

    init(shareResult: Result<Share> = Result.success(Share(name: "", symbol: "", value: 0.0)),
         certificatesResult: Result<[Certificate]> = Result.success([Certificate]()),
         sellResult: Result<Bool> = Result.success(true)) {
        self.shareResult = shareResult
        self.certificatesResult = certificatesResult
        self.sellResult = sellResult
    }

    func getCertificateList() -> Single<Result<[Certificate]>>{
        return Observable.of(certificatesResult).asSingle()
    }

    func getCurrentSharePrice() -> Single<Result<Share>> {
        return Observable.of(shareResult).asSingle()
    }

    func postSellCertificates(_ certificates: [Certificate]) -> Observable<Event<Result<Bool>>> {
        let result = Result.success(true)
        return Observable.of(result)
            .materialize()
    }
}
