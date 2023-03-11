//
//  NetworkProvider.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import Foundation

struct NetworkProvider<Target: TargetType> {
    func request(_ target: Target) throws -> URLRequest {
        let path = target.baseURL + target.path
        guard let urlComponents = URLComponents(string: path) else {
            throw NetworkError.invalidURLComponents(path)
        }
        var url: URL?
        let task = target.task
        switch task {
        case .requestPlain:
            url = urlComponents.url
        }
        guard let url = url else {
            throw NetworkError.invalidURLString
        }
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        if let headerField = target.headers {
            _ = headerField.map { (key, value) in
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
}
