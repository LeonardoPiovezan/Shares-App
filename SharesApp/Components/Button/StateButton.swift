//
//  StateButton.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 13/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit
import RPCircularProgress

class StateButton: UIButton {

    private var settedTitle: String?

    var progress: RPCircularProgress?

    var color: UIColor = .mainBlue {
        didSet {
            self.updateState()
        }
    }

    var borderColor: UIColor? {
        didSet {
            self.updateState()
        }
    }

    var textColor: UIColor = .white {
        didSet {
            self.updateState()
        }
    }

    var textSize: CGFloat = 0.0 {
        didSet {
            self.updateState()
        }
    }

    var disabledColor: UIColor = .lightGray {
        didSet {
            self.updateState()
        }
    }

    var cornerRadius: CGFloat = 3

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }

    override var isEnabled: Bool {
        didSet {
            self.updateState()
        }
    }

    var isLoading: Bool = false {
        didSet {
            if isLoading {
                setLoading()
            } else {
                setNormalButton()
            }
        }
    }

    override func prepareForInterfaceBuilder() {
        self.setupView()
        self.updateState()
    }

    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        self.setAttributedTitle(attributedTitleConfiguration(), for: .normal)
    }

    private func setupView() {
        self.layer.cornerRadius = self.cornerRadius

        self.progress = CircularProgressView()
        self.progress?.isHidden = true
        self.addSubview(progress!)
        self.progress?.snp.makeConstraints({ make in
            make.center.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(20)
        })
        self.updateState()
    }

    private func updateState() {
        self.backgroundColor = self.isEnabled ? self.color : self.disabledColor
        self.alpha = self.isEnabled ? 1.0 : 0.5
        self.setAttributedTitle(attributedTitleConfiguration(), for: .normal)
        if let borderColor = self.borderColor {
            self.layer.borderWidth = 2.0
            self.layer.borderColor = self.isEnabled ? borderColor.cgColor : disabledColor.cgColor
        }
    }

    private func attributedTitleConfiguration() -> NSAttributedString? {
        var currentTitle = ""
        var currentSize: CGFloat = self.textSize

        if let title = self.title(for: .normal) {
            currentTitle = title
        }

        if let size = self.titleLabel?.font.pointSize {
            if currentSize.isZero {
                currentSize = size
            }
        }

        return NSAttributedString(string: currentTitle,
                                  attributes: [
            NSAttributedString.Key.font: UIFont(name: Constants.Font.helveticaNeue, size: currentSize)!,
            NSAttributedString.Key.foregroundColor: self.textColor
            ]
        )
    }

    func setLoading() {
        if let title = self.title(for: .normal) {
            self.settedTitle = title
        }

        self.setTitle("", for: .normal)
        self.progress?.isHidden = false
        self.isUserInteractionEnabled = false
    }

    func setNormalButton() {
        self.progress?.isHidden = true
        self.isUserInteractionEnabled = true

        if let title = self.settedTitle {
            self.setTitle(title, for: .normal)
        }
    }

}
