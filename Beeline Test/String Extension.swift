//
//  String Extension.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 10.11.2022.
//

import Foundation
import UIKit

extension String {

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
            let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
            let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

            return ceil(boundingBox.width)
        }
        
        func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
            let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.text = self
            label.font = font
            label.sizeToFit()

            return label.frame.height
         }
}
