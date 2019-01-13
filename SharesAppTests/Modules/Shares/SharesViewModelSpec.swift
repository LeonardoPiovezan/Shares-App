//
//  SharesViewModelSpec.swift
//  SharesAppTests
//
//  Created by Leonardo Piovezan on 12/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Quick
import RxSwift
import RxCocoa
import RxTest
import RxNimble
import Nimble

@testable import SharesApp

class SharesViewModelSpec: QuickSpec {

    var subject: SharesViewModel!
    var scheduler: TestScheduler!
    var repository: MockSharesRepository!
    var disposeBag: DisposeBag = DisposeBag()
    var shareResult: Result<Share>!
    var certificatesResult: Result<[Certificate]>!
    var sellResult: Result<Bool> = Result.success(true)

    override func spec() {
        describe("Test SharesView Behaviour") {
            context("Test Drivers When Result is Success") {
                beforeEach {
                    let certificate = Certificate(certificateId: 0, numberOfShares: 100, issuedDate: "")
                    let result = Result.success([certificate])
                    self.scheduler = TestScheduler(initialClock: 0)
                    self.shareResult = Result.success(Share(name: "Name", symbol: "Symbol", value: 4.0))
                    self.certificatesResult = result
                    self.repository = MockSharesRepository(shareResult: self.shareResult,
                                                           certificatesResult: self.certificatesResult,
                                                        sellResult: self.sellResult)

                    self.subject = SharesViewModel(repository: self.repository)
                }


                it("Test Share Title Driver") {
                    let title = self.scheduler.createObserver(String.self)
                    self.subject
                        .shareTitle
                        .drive(title)
                        .disposed(by: self.disposeBag)

                    self.scheduler.start()
                    expect(title.events).to(equal([.next(0, "Current Share Price: 4.00")]))
                }

                it("Test Certificates Driver") {
                    let certificates = self.scheduler.createObserver([Certificate].self)

                    self.subject.certificates
                        .drive(certificates)
                        .disposed(by: self.disposeBag)

                    self.scheduler.start()

                    let expectedCertificates = [Certificate(certificateId: 0, numberOfShares: 100, issuedDate: "")]
                    expect(certificates.events).to(equal([.next(0, expectedCertificates)]))
                }
            }
        }
    }
}
