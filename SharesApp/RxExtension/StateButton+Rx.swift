//
//  StateButton+Rx.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 13/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: StateButton {
    var isLoading: Binder<Bool> {
        return Binder(self.base) { button, loading in
            button.isLoading = loading
        }
    }
}
