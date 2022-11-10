//
//  NetworkService.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 11.11.2022.
//

import Foundation
import Moya

enum NetworkService {
    case getProducts
}

extension NetworkService: TargetType {

    var baseURL: URL {
        return URL(string: Constant.API.baseURL)!
    }

    var path: String {
        switch self {
        case .getProducts:
            return "/products"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getProducts:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getProducts:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}



