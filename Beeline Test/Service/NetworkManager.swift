//
//  NetworkService.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 11.11.2022.
//

import Foundation

enum ObtainProductResult {
    case success(products: Product)
    case failure(error: Error)
}

class NetworkManager {
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    func obtainProducts(completion: @escaping (ObtainProductResult) -> Void) {
        guard let url = URL(string: Constant.API.baseURL) else { return }
        
        session.dataTask(with: url) { [weak self] (data, response, error) in
            var result: ObtainProductResult
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            guard let strongSelf = self else {
                result = .failure(error: error!)
                return
            }
            
            if error == nil, let parseData = data {
                guard let products = try? strongSelf.decoder.decode(Product.self, from: parseData) else {
                    result = .failure(error: error!)
                    return
                }
                    result = .success(products: products)
                } else {
                    result = .failure(error: error!)
            }
        }.resume()
    }
}
