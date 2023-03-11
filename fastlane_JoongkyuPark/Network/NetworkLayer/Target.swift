//
//  Target.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import Foundation

enum Target {
    case getYeoshinData
}

extension Target: TargetType {
    var baseURL: String {
        switch self {
        case .getYeoshinData:
            return "https://f9c1a8f3-132d-451a-988f-47527dbda002.mock.pstmn.io/"
        }
    }
    
    var path: String {
        switch self {
        case .getYeoshinData:
            return "latest/ios2/product"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getYeoshinData:
            return .get
        }
    }
    
    var task: NetworkTask {
        switch self {
        case .getYeoshinData:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getYeoshinData:
            return ["Content-Type": "application/json"]
        }
    }
}
