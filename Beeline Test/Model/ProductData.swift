//
//  ProductData.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 11.11.2022.
//

import Foundation

struct ProductData: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String?
    let images: [String]
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case title
//        case description
//        case price
//        case discountPercentage
//        case rating
//        case stock
//        case brand
//        case category
//        case thumbnail
//        case images
//    }
}
