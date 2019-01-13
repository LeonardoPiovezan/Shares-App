//
//  SharesRouter.swift
//  SharesApp
//
//  Created by Leonardo Piovezan on 11/01/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Moya

enum SharesRouter {
    case certificatesList
    case currentSharePrice
    case sellCertificates(certificates: [Certificate])
}

extension SharesRouter: TargetType {
    var baseURL: URL {
        switch self {
        case .sellCertificates:
            return URL(string: Constants.Network.basePostURL)!
        default:
            return URL(string: Constants.Network.baseURL)!
        }

    }

    var path: String {
        switch self {
        case .certificatesList:
            return "sampledata"
        case .currentSharePrice:
            return "fmv"
        case .sellCertificates:
            return "d1aa13f3-b4d4-4608-ad0e-12cc5feab319"
        }
    }

    var method: Method {
        switch self {
        case .sellCertificates:
            return .post
        default:
             return .get
        }

    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .sellCertificates(let certificates):
            return .requestCustomJSONEncodable(certificates, encoder: JSONEncoder())
        default:
             return .requestPlain
        }
    }

    var headers: [String : String]? {
        return nil
    }
}
