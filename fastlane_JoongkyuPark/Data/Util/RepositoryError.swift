//
//  RepositoryError.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import Foundation

enum RepositoryError: Error {
    case decodingError(toType: Decodable.Type)
    
    var description: String {
        switch self {
        case .decodingError(let type):
            return "Decoding error(type: \(type)."
        }
    }    
}
