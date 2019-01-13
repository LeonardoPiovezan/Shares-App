//
//  UIColor+Utils.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 12/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(Double(r) / 255.0),
                  green: CGFloat(Double(g) / 255.0),
                  blue: CGFloat(Double(b) / 255.0),
                  alpha: 1)
    }
}

extension UIColor {
    @nonobjc class var shadowGray: UIColor {
        return UIColor(r: 130, g: 146, b: 158)
    }

    @nonobjc class var lightGray: UIColor {
        return UIColor(r: 130, g: 130, b: 130)
    }
    
    @nonobjc class var mainGray: UIColor {
        return UIColor(r: 56, g: 69, b: 88)
    }

    @nonobjc class var flatWhite: UIColor {
        return UIColor(r: 249, g: 249, b: 249)
    }

    @nonobjc class var lightBlack: UIColor {
        return UIColor(r: 36, g: 36, b: 36)
    }

    @nonobjc class var mainBlue: UIColor{
        return UIColor(r: 35, g: 151, b: 212)
    }

}
