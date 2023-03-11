//
//  DefaultYeoshinRepository.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import Foundation

import RxSwift

final class DefaultYeoshinRepository: YeoshinRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchYeoshinItem() -> Observable<YeoshinItem> {
        return networkService.get(targetType: .getYeoshinData)
            .map({ result in
                switch result {
                case .success(let data):
                    guard let dto = self.decode(from: data, to: YeoshinResponseDTO.self) else {
                        throw RepositoryError.decodingError(toType: YeoshinResponseDTO.self)
                    }
                    return dto.toDomain()
                case .failure(let error):
                    throw error
                }
            })
    }
}

extension DefaultYeoshinRepository {
    func decode<T: Decodable>(from data: Data, to type: T.Type) -> T? {
        return try? JSONDecoder().decode(type, from: data)
    }
}
