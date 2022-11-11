//
//  Constanrt.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 11.11.2022.
//

import Foundation
import UIKit

struct Constant{
    
    struct API {
        static let baseURL = "https://dummyjson.com"
    }
    
    struct AttributedText {
        static let attributedText = NSAttributedString(
            string: "Label Text",
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
    }
}
