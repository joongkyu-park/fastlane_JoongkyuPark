//
//  NetworkAPI.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import Foundation

import RxSwift

struct NetworkAPI {
    private let provider = NetworkProvider<NetworkService>()
}

extension NetworkAPI {
    func get(targetType: NetworkService) -> Observable<Result<Data, NetworkError>> {
        return Observable.create { emitter in
            do {
                let request = try provider.request(targetType)
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let response = response as? HTTPURLResponse else {
                        emitter.onError(NetworkError.invalidServerResponse)
                        return
                    }
                    if error != nil {
                        emitter.onError(NetworkError.httpError(response.statusCode))
                        return
                    }
                    guard 200..<300 ~= response.statusCode else {
                        emitter.onError(NetworkError.httpError(response.statusCode))
                        return
                    }
                    guard let data = data else {
                        emitter.onNext(.failure(NetworkError.nonData))
                        return
                    }
                    emitter.onNext(.success(data))
                    emitter.onCompleted()
                }
                task.resume()
                
                return Disposables.create {
                    task.cancel()
                }
            } catch let error {
                emitter.onError(error)
            }
            return Disposables.create()
        }
    }
}
