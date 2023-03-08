//
//  YeoshinEvent.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import Foundation

struct YeoshinEvent: Equatable {
    let name: String
    let comment: String
    let customerName: String
    let displayName: String
    let locationName: String
    let price: Int
    let currecny: String
    let wishCount: Int
    let reviewCount: Int
    let rate: Double
    let imageURL: String
    let isEnableReservation: Bool
}
