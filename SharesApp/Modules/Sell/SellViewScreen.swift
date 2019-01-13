//
//  SellViewScreen.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 12/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

class SellViewScreen: UIView {

    private lazy var wrapperView: ShadowView = {
        let view = ShadowView(frame: CGRect.zero)
        return view
    }()

    lazy var numberOfSharesView: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        return view
    }()

    lazy var sharesToSellView: TitleAndTextFieldView = {
        let view = TitleAndTextFieldView()
        view.textField.keyboardType = .numberPad
        view.textField.isAccessibilityElement = true
        view.textField.accessibilityLabel = "sharesToSell"
        return view
    }()

    lazy var currentShareValue: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        return view
    }()

    lazy var totalValueView: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        return view
    }()

    lazy var sellButton: StateButton = {
        let button = StateButton(frame: CGRect.zero)
        button.isAccessibilityElement = true
        button.accessibilityLabel = "sellButton"
        return button
    }()

    init() {
        super.init(frame: CGRect.zero)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SellViewScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.wrapperView)
        self.wrapperView.addSubview(self.numberOfSharesView)
        self.wrapperView.addSubview(self.sharesToSellView)
        self.wrapperView.addSubview(self.currentShareValue)
        self.wrapperView.addSubview(self.totalValueView)
        self.addSubview(self.sellButton)
    }

    func setupConstraints() {
        self.wrapperView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()

        }

        self.numberOfSharesView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }

        self.sharesToSellView.snp.makeConstraints { make in
            make.top.equalTo(self.numberOfSharesView.snp.bottom)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }

        self.currentShareValue.snp.makeConstraints { make in
            make.top.equalTo(self.sharesToSellView.snp.bottom)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }

        self.totalValueView.snp.makeConstraints { make in
            make.top.equalTo(self.currentShareValue.snp.bottom)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().offset(8)
        }

        self.sellButton.snp.makeConstraints { make in
            make.top.equalTo(self.wrapperView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(30)
        }

    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .flatWhite

        self.numberOfSharesView.titleLabel.text = "Number Of Shares"
        self.numberOfSharesView.descriptionLabel.text = "0"

        self.sharesToSellView.titleLabel.text = "Shares to sell"

        self.currentShareValue.titleLabel.text = "Current Share Value"
        self.currentShareValue.descriptionLabel.text = "0.00"

        self.totalValueView.titleLabel.text = "Total Value"
        self.totalValueView.descriptionLabel.text = "0.00"

        self.sellButton.setTitle("sell", for: .normal)

        self.isAccessibilityElement = true
        self.accessibilityLabel = "sellView"
    }
}

