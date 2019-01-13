//
//  SellViewModel.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 12/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftUtilities

class SellViewModel {

    let title: Driver<String>
    let certificateTitle: Driver<String>
    let numberOfShares: Driver<String>
    let currentShareValue: Driver<String>
    let totalValue: Driver<String>
    let isEnabled: Driver<Bool>
    let isUploading: Driver<Bool>
    let askValidation: Driver<Void>

    let uploadedSuccessfully = PublishSubject<Void>()
    let failedUploading = PublishSubject<Void>()

    private let disposeBag = DisposeBag()

    init(certificate: Observable<Certificate>,
         sharesToSell: Observable<String>,
         repository: SharesRepository,
         sellTap: Signal<Void>,
         confirmTap: Signal<Void>) {

        let sharePrice = Observable<Int>
            .timer(0.0,
                   period: RxTimeInterval(exactly: Constants.Time.refreshShare),
                   scheduler: MainScheduler.instance)
            .startWith(0)
            .flatMap({ _ in
                return repository.getCurrentSharePrice()
            })

        let shareSubject = ReplaySubject<Share>.create(bufferSize: 1)
        sharePrice.subscribe(onNext: { result in
            switch result {
            case .success(let share):
                shareSubject.onNext(share)
            case .error:
                ()
            }
        }).disposed(by: self.disposeBag)

        let share = shareSubject.asObservable().share()

        let shareValue = share.map { $0.value }

        let numberOfShares = certificate
            .map { $0.numberOfShares }
            .share()

        let numberOfSharesAndSharesToSell = Observable.combineLatest(numberOfShares, sharesToSell).share()

        self.title = share.map { $0.name }
            .asDriver(onErrorJustReturn: "")
        self.certificateTitle = certificate.map { "Number of Shares - Certificate \($0.certificateId)" }
            .asDriver(onErrorJustReturn: "")

        self.numberOfShares = numberOfShares
            .map { String($0) }
            .asDriver(onErrorJustReturn: "")

        self.currentShareValue = shareSubject.map { $0.value }
            .map { String.localizedStringWithFormat("%.2f", $0) }
            .asDriver(onErrorJustReturn: "0.00")
        self.totalValue = Observable.combineLatest(certificate,
                                                   sharesToSell,
                                                   shareValue)
            .map { _, sharesToSell, shareValue -> Float in
                let shares = Float(sharesToSell) ?? 0.0
                let total = (shareValue * shares)

                return total
            }
            .map { value in
                return String.localizedStringWithFormat("%.2f", value)
            }
            .asDriver(onErrorJustReturn: "")

        self.isEnabled = numberOfSharesAndSharesToSell
            .map { numberOfShares, sharesToSell in
            let shares = Int(sharesToSell) ?? 0
            return numberOfShares >= shares && shares > 0
            }
            .startWith(false)
            .asDriver(onErrorJustReturn: true)


        let certificateSell = Observable.combineLatest(certificate, sharesToSell)
            .map { (arg) -> Certificate in
                let (certificate, shares) = arg
                let numberOfShares = Int(shares) ?? 0
                return Certificate(certificateId: certificate.certificateId,
                                   numberOfShares: numberOfShares,
                                   issuedDate: certificate.issuedDate)
        }

        let activityIndicator = ActivityIndicator()

        self.isUploading = activityIndicator.asDriver(onErrorJustReturn: false)


        let isValidationNecessary = sellTap
            .asObservable()
            .withLatestFrom(numberOfSharesAndSharesToSell)
            .map { (current, toSell) -> Bool in
                let sellValue = Int(toSell) ?? 0
                return sellValue > current/2
        }.share()

        self.askValidation = isValidationNecessary
            .filter { $0 }
            .map {_ in () }
            .asDriver(onErrorJustReturn: ())

        let validationIsNotNecessary = isValidationNecessary
            .filter { !$0 }
            .map { _ in () }
        let sellEvent = Observable.merge(validationIsNotNecessary, confirmTap.asObservable())
            .withLatestFrom(certificateSell)
            .flatMapLatest { certificate in
                return repository.postSellCertificates([certificate])
                    .trackActivity(activityIndicator)
            }.filter { !$0.isCompleted }

        let sellResult = sellEvent.map { event -> Result<Bool> in
            if event.error != nil {
                self.failedUploading.onNext(())
                return Result.error(error: event.error!)
            }
            return event.element ?? Result.success(false)
        }

        sellResult.subscribe(onNext: { result in
            switch result {
            case .success:
                self.uploadedSuccessfully.onNext(())
            case .error:
                self.failedUploading.onNext(())
            }
        }).disposed(by: self.disposeBag)
    }
}
