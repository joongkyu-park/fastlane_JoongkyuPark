//
//  NetworkRepositoryProtocol.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import Foundation

import RxSwift

protocol NetworkRepositoryProtocol {
    func fetchYeoshin() -> Observable<Yeoshin>
}
