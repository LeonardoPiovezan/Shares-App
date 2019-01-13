//
//  SellViewModelSpec.swift
//  SharesAppTests
//
//  Created by Leonardo Piovezan on 13/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Quick
import Nimble
import RxTest
import RxSwift
import RxCocoa

@testable import SharesApp

class SellViewModelSpec: QuickSpec {
    var subject: SellViewModel!
    var scheduler: TestScheduler!
    var certificateObservable: Observable<Certificate>!
    var sharesToSellObservable: Observable<String>!
    var sellTap: Signal<Void>!
    var confirmTap: Signal<Void>!
    var repository: MockSharesRepository!
    var disposeBag: DisposeBag = DisposeBag()

    override func spec() {
        describe("SellView Behaviour") {
            context("Test Drivers When Result is Success") {
                beforeEach {
                    self.prepareTest()
                    let share = Share(name: "ABC", symbol: "$", value: 3.5)
                    let repository = MockSharesRepository(shareResult: Result<Share>.success(share))

                    self.subject = SellViewModel(certificate: self.certificateObservable,
                                                 sharesToSell: self.sharesToSellObservable,
                                                 repository: repository,
                                                 sellTap: self.sellTap,
                                                 confirmTap: self.confirmTap)
                }

                it("Test Title") {
                    let title = self.scheduler.createObserver(String.self)
                    self.subject
                        .title
                        .drive(title)
                        .disposed(by: self.disposeBag)

                    self.scheduler.start()
                    expect(title.events).to(equal([.next(0, "ABC")]))
                }

                it("Test Certificate Title") {
                    let title = self.scheduler.createObserver(String.self)
                    self.subject
                        .certificateTitle
                        .drive(title)
                        .disposed(by: self.disposeBag)

                    self.scheduler.start()
                    expect(title.events).to(equal([.next(0, "Number of Shares - Certificate 1")]))
                }

                it("Test Number Of Shares Available") {
                    let numberOfShares = self.scheduler.createObserver(String.self)
                    self.subject
                        .numberOfShares
                        .drive(numberOfShares)
                        .disposed(by: self.disposeBag)

                    self.scheduler.start()
                    expect(numberOfShares.events).to(equal([.next(0, "100")]))
                }

                it("Test Current Share Value") {
                    let currentValue = self.scheduler.createObserver(String.self)
                    self.subject
                        .currentShareValue
                        .drive(currentValue)
                        .disposed(by: self.disposeBag)

                    self.scheduler.start()
                    expect(currentValue.events).to(equal([.next(0, "3.50")]))
                }

                it("Test Total Value When Valid Inputs") {
                    let totalValue = self.scheduler.createObserver(String.self)
                    self.subject
                        .totalValue
                        .drive(totalValue)
                        .disposed(by: self.disposeBag)

                    self.scheduler.start()

                    expect(totalValue.events).to(equal([.next(0, "245.00"),
                                                        .next(1, "350.00"),
                                                        .next(2, "700.00"),
                                                        .next(3, "0.00")]))
                }

                it("Test IsEnabled Sell button") {
                    let isEnabled = self.scheduler.createObserver(Bool.self)
                    self.subject
                        .isEnabled
                        .drive(isEnabled)
                        .disposed(by: self.disposeBag)

                    self.scheduler.start()
                    expect(isEnabled.events).to(equal([.next(0, false),
                                                       .next(0, true),
                                                       .next(1, true),
                                                       .next(2,false),
                                                       .next(3, false)]))
                }

                it("Test Ask Validation") {
                    let askValidation = self.scheduler.createObserver(Bool.self)
                    self.subject
                        .askValidation
                        .map { _ in true }
                        .drive(askValidation)
                        .disposed(by: self.disposeBag)

                    self.scheduler.start()

                    expect(askValidation.events).to(equal([.next(0, true),
                                                           .next(1, true),
                                                           .next(2, true)
                                                         ]))
                }

                it("Test Upload Successfully") {
                    let uploaded = self.scheduler.createObserver(Bool.self)
                    self.subject
                        .uploadedSuccessfully
                        .asDriver(onErrorJustReturn: ())
                        .map { _ in true }
                        .drive(uploaded)
                        .disposed(by: self.disposeBag)

                    self.scheduler.start()
                    expect(uploaded.events).to(equal([.next(0,true)]))
                }
            }

            context("Check When Result Is Failure") {
                beforeEach {
                    self.prepareTest()
                    let repository = MockSharesRepository(shareResult: Result<Share>.error(error: GenericError(message: "Request failed")))

                    self.subject = SellViewModel(certificate: self.certificateObservable,
                                                 sharesToSell: self.sharesToSellObservable,
                                                 repository: repository,
                                                 sellTap: self.sellTap,
                                                 confirmTap: self.confirmTap)
                }
            }
        }
    }

    func prepareTest() {
        self.scheduler = TestScheduler(initialClock: 0)

        let certificate = Certificate(certificateId: 1,
                                      numberOfShares: 100,
                                      issuedDate: "")

        self.certificateObservable = self.scheduler
            .createColdObservable([.next(0, certificate)])
            .asObservable()

        self.sharesToSellObservable = self.scheduler
            .createColdObservable([.next(0, "70"),
                                   .next(1, "100"),
                                   .next(2, "200"),
                                   .next(3, "0")])
            .asObservable()

        self.sellTap = self.scheduler
            .createColdObservable([.next(0, ()),
                                   .next(1, ()),
                                   .next(2, ())
                ])
            .asSignal(onErrorJustReturn: ())

        self.confirmTap = self.scheduler.createColdObservable([.next(0,())])
            .asSignal(onErrorJustReturn: ())

    }
}
