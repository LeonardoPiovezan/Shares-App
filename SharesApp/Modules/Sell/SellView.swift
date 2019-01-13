//
//  SellView.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 12/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit
import RxSwift

class SellView: UIViewController {

    var certificate: Certificate!
    
    private let repository: SharesRepository
    private var screen: SellViewScreen!
    private var viewModel: SellViewModel!
    private let disposeBag = DisposeBag()
    private let confirmSellSubject = PublishSubject<Void>()

    init(repository: SharesRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.screen = SellViewScreen()
        self.view = self.screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupBindings()
    }

    func setupViewModel() {

        let sharesToSell = self.screen.sharesToSellView.textField
            .rx
            .text
            .asObservable()
            .map { $0 ?? "" }

        let sellTap = self.screen.sellButton.rx.tap.asSignal()
        self.viewModel = SellViewModel(certificate: Observable.of(self.certificate),
                                       sharesToSell: sharesToSell,
                                       repository: self.repository,
                                       sellTap: sellTap,
                                       confirmTap: self.confirmSellSubject.asSignal(onErrorJustReturn: ()))
    }

    func setupBindings() {
        self.viewModel.title
            .drive(self.rx.title)
            .disposed(by: self.disposeBag)

        self.viewModel.certificateTitle
            .drive(self.screen.numberOfSharesView
                .titleLabel
                .rx
                .text)
            .disposed(by: self.disposeBag)

        self.viewModel.numberOfShares
            .drive(self.screen.numberOfSharesView
                .descriptionLabel
                .rx
                .text)
            .disposed(by: self.disposeBag)

        self.viewModel.currentShareValue
            .drive(self.screen.currentShareValue
                .descriptionLabel
                .rx
                .text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.totalValue
            .drive(self.screen.totalValueView
                .descriptionLabel
                .rx
                .text)
            .disposed(by: self.disposeBag)

        self.viewModel
            .isEnabled
            .drive(self.screen.sellButton
                .rx
                .isEnabled)
            .disposed(by: self.disposeBag)

        self.viewModel
            .isUploading
            .drive(self.screen.sellButton
                .rx
                .isLoading)
            .disposed(by: self.disposeBag)

        self.viewModel
            .uploadedSuccessfully
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] _ in
                let alert = UIAlertController(title: "Sell Action",
                                              message: "You sold successfully your shares",
                                              preferredStyle: UIAlertController.Style.alert)

                let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { [weak self] _ in
                    self?.navigationController?.popToRootViewController(animated: true)
                })
                alert.addAction(alertAction)
                self?.present(alert, animated: true, completion: nil)
            })
            .disposed(by: self.disposeBag)

        self.viewModel
            .failedUploading
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] _ in
                let alert = UIAlertController(title: "Sell Action",
                                              message: "We could not complete the operation",
                                              preferredStyle: UIAlertController.Style.alert)

                let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(alertAction)
                self?.present(alert, animated: true, completion: nil)
            })
        .disposed(by: self.disposeBag)

        self.viewModel
            .askValidation
            .drive(onNext: { [weak self] _ in
                let alert = UIAlertController(title: "Sell Action",
                                              message: "Are you sure you want to sell more than 50% of your shares?",
                                              preferredStyle: UIAlertController.Style.alert)
                
                alert.view.isAccessibilityElement = true
                alert.view.accessibilityLabel = "verificationAlert"
                

                let confirmAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { [weak self] _ in

                    self?.confirmSellSubject.onNext(())
                })

                let dismissAction = UIAlertAction(title: "No", style: .default, handler: nil)
                alert.addAction(dismissAction)
                alert.addAction(confirmAction)
                self?.present(alert, animated: true, completion: nil)
            })
        .disposed(by: self.disposeBag)
    }

}
