//
//  SharesService.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 11/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import RxSwift
import Moya

protocol SharesService {
    func getCertificateList() -> Single<Response>
    func getCurrentSharePrice() -> Single<Response>
    func postSellCertificates(_ certificates: [Certificate]) -> Single<Response>
}
