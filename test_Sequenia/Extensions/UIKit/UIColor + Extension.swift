//
//  UIColor + Extension.swift
//  test_Sequenia
//
//  Created by aleksandr_rudikov on 08.09.2021.
//

import UIKit

extension UIColor {
    static var mainPurple: UIColor {
        return #colorLiteral(red: 0.4862745098, green: 0.4274509804, blue: 0.968627451, alpha: 1)
    }
    
    static func ratingTextColor(for text: String?) -> UIColor {
        guard let text = text else { return .label }
        guard let num = Double(text) else { return .label}
        switch num {
        case 0..<5:
            return #colorLiteral(red: 1, green: 0.0431372549, blue: 0.0431372549, alpha: 1)
        case 5..<6:
            return #colorLiteral(red: 0.3725490196, green: 0.3725490196, blue: 0.3725490196, alpha: 1)
        default:
            return #colorLiteral(red: 0, green: 0.4823529412, blue: 0, alpha: 1)
        }
    }
}
