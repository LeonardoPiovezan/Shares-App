//
//  Certificate.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 11/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

struct Certificate: Codable, Equatable {
    let certificateId: Int
    let numberOfShares: Int
    let issuedDate: String

    init(certificateId: Int,
         numberOfShares: Int,
         issuedDate: String) {
        self.certificateId = certificateId
        self.numberOfShares = numberOfShares
        self.issuedDate = issuedDate
    }
}
