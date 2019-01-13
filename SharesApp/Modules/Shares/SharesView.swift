//
//  SharesView.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 11/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol SharesViewDelegate: class {
    func showSellView(certificate: Certificate)
}

class SharesView: UIViewController {

    var viewModel: SharesViewModel!

    weak var delegate: SharesViewDelegate!

    private var screen: SharesViewScreen!

    private let repository: SharesRepository
    private let disposeBag = DisposeBag()

    init(repository: SharesRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.screen = SharesViewScreen()
        self.view = self.screen
        self.view.isAccessibilityElement = true
        self.view.accessibilityLabel = "sharesView"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func setupViewModel() {
        self.viewModel = SharesViewModel(repository: self.repository)
    }

    func setupBindings() {
        self.viewModel.certificates
            .drive(self.screen.tableView
                .rx
                .items(cellIdentifier: "ShareCell", cellType: CertificateTableViewCell.self)) { _, element, cell in
                    cell.titleLabel.text = "Certificate \(element.certificateId)"
                    cell.numberOfSharesLabel.text = "Number of shares: \(element.numberOfShares)"
        }.disposed(by: self.disposeBag)

        self.viewModel.shareTitle
            .drive(self.screen.shareLabel.rx.text)
        .disposed(by: self.disposeBag)

        self.screen.tableView.rx.modelSelected(Certificate.self)
            .subscribe(onNext: { certificate in
                self.delegate.showSellView(certificate: certificate)
            })
        .disposed(by: self.disposeBag)
    }

}
