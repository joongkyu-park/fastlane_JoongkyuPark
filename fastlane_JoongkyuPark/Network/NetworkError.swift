//
//  NetworkError.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import Foundation

enum NetworkError: Error {
    
    case httpError(Int)
    case invalidURLComponents(String)
    case invalidURLString
    case invalidServerResponse
    case nonStatusCode
    case nonData
    
    var description: String {
        switch self {
        case .httpError(let statusCode):
            return "HTTP error(statusCode: \(statusCode)."
        case .invalidURLComponents(let path):
            return "Invalid URL Components(path: \(path)."
        case .invalidURLString:
            return "Invalid URL String."
        case .invalidServerResponse:
            return "Invalid server response."
        case .nonStatusCode:
            return "Non status code."
        case .nonData:
            return "Non data."
        }
    }
    
}
