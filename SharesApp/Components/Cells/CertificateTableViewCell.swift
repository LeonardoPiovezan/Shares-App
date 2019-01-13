//
//  CertificateTableViewCell.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 12/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

final class CertificateTableViewCell: UITableViewCell {
    lazy var shadowView: ShadowView = {
        let view = ShadowView(frame: CGRect.zero)
        view.backgroundColor = .white
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont(name: Constants.Font.helveticaNeue, size: 16)
        label.numberOfLines = 0
        label.textColor = .lightBlack
        return label
    }()

    lazy var numberOfSharesLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont(name: Constants.Font.helveticaNeueLight, size: 14)
        label.numberOfLines = 0
        label.textColor = .lightGray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CertificateTableViewCell: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.shadowView)
        self.shadowView.addSubview(self.titleLabel)
        self.shadowView.addSubview(self.numberOfSharesLabel)
    }

    func setupConstraints() {
        self.shadowView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }

        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview()
        }

        self.numberOfSharesLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview()
            make.bottom.bottom.equalToSuperview().inset(16)
        }
    }

    func setupAdditionalConfiguration() {
        self.selectionStyle = .none
        self.backgroundColor = .flatWhite
    }
}
