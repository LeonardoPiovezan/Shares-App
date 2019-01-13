//
//  Constants.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 11/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation

struct Constants {
    private init() {}

    struct Network {
        private init() {}
        static let baseURL = "http://developerexam.equityplansdemo.com/test"
        static let basePostURL = "https://webhook.site/#"
    }

    struct Time {
        private init() {}
        static let refreshShare = 30
    }
    struct Font {
        private init(){}
        static let helveticaNeue = "HelveticaNeue"
        static let helveticaNeueLight = "HelveticaNeue-Light"
    }
}
