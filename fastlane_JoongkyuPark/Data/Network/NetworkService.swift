//
//  NetworkService.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import Foundation

enum NetworkService {
    
    case getYeoshin
    
}

extension NetworkService: TargetType {
    
    var baseURL: String {
        switch self {
        case .getYeoshin:
            return "https://f9c1a8f3-132d-451a-988f-47527dbda002.mock.pstmn.io/"
        }
    }
    
    var path: String {
        switch self {
        case .getYeoshin:
            return "latest/ios2/product"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getYeoshin:
            return .get
        }
    }
    
    var task: NetworkTask {
        switch self {
        case .getYeoshin:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getYeoshin:
            return ["Content-Type": "application/json"]
        }
    }
    
}
