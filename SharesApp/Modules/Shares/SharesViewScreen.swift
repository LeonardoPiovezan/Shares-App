//
//  SharesViewScreen.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 11/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit
import SnapKit

final class SharesViewScreen: UIView {
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero)
        table.separatorStyle = .none
        table.backgroundColor = .flatWhite
        table.isAccessibilityElement = true
        table.accessibilityLabel = "sharesTable"
        return table
    }()

    private lazy var shareView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .mainBlue
        return view
    }()

    lazy var shareLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont(name: Constants.Font.helveticaNeue, size: 24)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    init() {
        super.init(frame: CGRect.zero)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SharesViewScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.shareView)
        self.addSubview(self.tableView)
        self.shareView.addSubview(self.shareLabel)
    }

    func setupConstraints() {
        self.shareView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }

        self.shareLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(41)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }

        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.shareView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .flatWhite
        self.tableView.register(CertificateTableViewCell.self, forCellReuseIdentifier: "ShareCell")
        self.shareLabel.text = "Current Share Price: 2.32"
    }
}
