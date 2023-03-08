//
//  TargetType.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import Foundation

protocol TargetType {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: NetworkTask { get }
    var headers: [String: String]? { get }
    
}
