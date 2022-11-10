//
//  Product.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 09.11.2022.
//

import Foundation

struct Product: Decodable {
    var productData: [ProductData]
    
    enum CodingKeys: String, CodingKey {
        case productData = "products"
    }
}
