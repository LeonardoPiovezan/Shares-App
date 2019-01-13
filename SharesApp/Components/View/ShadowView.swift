//
//  ShadowView.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 12/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//
import UIKit

class ShadowView: UIView {

    var shadowColor: UIColor = UIColor.shadowGray {
        didSet {
            self.configureShadow()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureShadow()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureShadow()
    }

    override func prepareForInterfaceBuilder() {
        self.configureShadow()
    }

    func configureShadow() {
        super.awakeFromNib()
        self.layer.cornerRadius = 3.0
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.shouldRasterize = false
        self.clipsToBounds = false
    }

}
