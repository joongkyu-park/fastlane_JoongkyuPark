//
//  NetworkRepository.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import Foundation

import RxSwift

final class NetworkRepository: NetworkRepositoryProtocol {
    private let networkAPI: NetworkAPI
    
    init(networkAPI: NetworkAPI) {
        self.networkAPI = networkAPI
    }
    
    func fetchYeoshin() -> Observable<Yeoshin> {
        return networkAPI.get(targetType: .getYeoshin)
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

extension NetworkRepository {
    func decode<T: Decodable>(from data: Data, to type: T.Type) -> T? {
        return try? JSONDecoder().decode(type, from: data)
    }
}
