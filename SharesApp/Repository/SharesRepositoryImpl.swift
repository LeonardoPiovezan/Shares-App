//
//  SharesRepositoryImpl.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 12/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import RxSwift

enum Result<T> {
    case success(T)
    case error(error: Error)
}

struct GenericError: LocalizedError {
    let message: String

    init(message: String) {
        self.message = message
    }

    var errorDescription: String? {
        return self.message
    }
}

final class SharesRepositoryImpl: SharesRepository {

    private let service: SharesService
    init(service: SharesService) {
        self.service = service
    }

    func getCertificateList() -> Single<Result<[Certificate]>> {
        return self.service.getCertificateList().map { response in
            let statusCode = response.statusCode
            if 200...299 ~= statusCode {
                do {
                    let certificates = try response.map([Certificate].self)
                    return Result.success(certificates)
                } catch let error {
                    return Result.error(error: error)
                }
            }

            let error = GenericError(message: "Request failed with code: \(statusCode)")
            return Result.error(error: error)
        }
    }

    func getCurrentSharePrice() -> Single<Result<Share>> {
        return self.service.getCurrentSharePrice().map { response in
            let statusCode = response.statusCode
            if 200...299 ~= statusCode {
                do {
                    let share = try response.map(Share.self)
                    return Result.success(share)
                } catch let error {
                    return Result.error(error: error)
                }
            }

            let error = GenericError(message: "Request failed with code: \(statusCode)")
            return Result.error(error: error)
        }
    }

    func postSellCertificates(_ certificates: [Certificate]) -> Observable<Event<Result<Bool>>> {
        return self.service.postSellCertificates(certificates).map { response in
            let statusCode = response.statusCode
            if 200...299 ~= statusCode {
                return Result.success(true)
            }

            let error = GenericError(message: "Request failed with code: \(statusCode)")
            return Result.error(error: error)
        }.asObservable()
        .materialize()
    }
}
