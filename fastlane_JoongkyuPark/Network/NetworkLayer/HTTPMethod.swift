//
//  HTTPMethod.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import Foundation

struct HTTPMethod {
    static let get = HTTPMethod(rawValue: "GET")
    let rawValue: String
    private init(rawValue: String) {
        self.rawValue = rawValue
    }
}
