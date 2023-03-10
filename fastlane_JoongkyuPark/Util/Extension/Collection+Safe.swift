//
//  Collection+Safe.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/11.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
