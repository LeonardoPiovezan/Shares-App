//
//  TitleAndTextFieldView.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 13/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

class TitleAndTextFieldView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont(name: Constants.Font.helveticaNeue, size: 16)
        label.numberOfLines = 0
        label.textColor = .lightBlack
        return label
    }()

    lazy var textField: UITextField = {
        let textField = UITextField(frame: CGRect.zero)
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: Constants.Font.helveticaNeue, size: 16)
        return textField
    }()

    init() {
        super.init(frame: CGRect.zero)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TitleAndTextFieldView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.textField)
    }

    func setupConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview()
        }

        self.textField.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.bottom.bottom.equalToSuperview().inset(16)
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .flatWhite
    }
}
