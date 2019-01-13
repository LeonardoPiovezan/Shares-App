//
//  SharesRepository.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 12/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import RxSwift

protocol SharesRepository {
    func getCertificateList() -> Single<Result<[Certificate]>>
    func getCurrentSharePrice() -> Single<Result<Share>>
    func postSellCertificates(_ certificates: [Certificate]) -> Observable<Event<Result<Bool>>>
}
