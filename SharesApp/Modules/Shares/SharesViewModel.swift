//
//  SharesViewModel.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 11/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import RxSwift
import RxCocoa

final class SharesViewModel {
    let certificates: Driver<[Certificate]>
    let shareTitle: Driver<String>

    private let disposeBag = DisposeBag()


    init(repository: SharesRepository) {
        let certificatesSubject = ReplaySubject<[Certificate]>.create(bufferSize: 1)
        let shareSubject = ReplaySubject<Share>.create(bufferSize: 1)

        let sharePrice = Observable<Int>
            .timer(0.0,
                   period: RxTimeInterval(exactly: Constants.Time.refreshShare),
                   scheduler: MainScheduler.instance)
            .startWith(0)
            .flatMap({ _ in
                return repository.getCurrentSharePrice()
            })

        repository.getCertificateList().subscribe(onSuccess: { result in
            switch result {
            case .success(let certificates):
                certificatesSubject.onNext(certificates)
            case .error:
                ()
            }
        }).disposed(by: self.disposeBag)

        sharePrice.subscribe(onNext: { result in
            switch result {
            case .success(let share):
                shareSubject.onNext(share)
            case .error:
                ()
            }
        }).disposed(by: self.disposeBag)

        self.certificates = certificatesSubject.asDriver(onErrorJustReturn: [])

        self.shareTitle = shareSubject
            .map { String.localizedStringWithFormat("%.2f", $0.value) }
            .map{ "Current Share Price: \($0)"}.asDriver(onErrorJustReturn: "")
    }
}
