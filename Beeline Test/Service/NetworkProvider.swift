//
//  NetworkProvider.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 11.11.2022.
//

import Foundation
import Moya

protocol NetworkProviderProtocol{
    var provider: MoyaProvider<NetworkService> { get }
    func getProducts(completion: @escaping (Result<Product, Error>) -> ())
}

class NetworkProvider: NetworkProviderProtocol {
    
    var provider = MoyaProvider<NetworkService>(plugins: [NetworkLoggerPlugin()])
    
    func getProducts(completion: @escaping (Result<Product, Error>) -> ()) {
        request(target: .getProducts, completion: completion)
    }
}


private extension NetworkProvider {
    private func request<T: Decodable>(target: NetworkService, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
