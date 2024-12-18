//
//  UIFont+AppFonts.swift
//  STestApp
//
//  Created by Artem Novichkov on 20.12.2023.
//

import Foundation
import UIKit

extension UIFont {

    //DRY
    static func appRegularFont(size: CGFloat) -> UIFont {
        UIFont(name: "SFProText-Regular", size: size)!
    }
}

extension UIColor {

    static let utility: UIColor = {
        UIColor { collection in
            if collection.userInterfaceStyle == .dark {
                return UIColor(red: 0.969, green: 0.973, blue: 0.976, alpha: 1)
            }
            return UIColor(red: 0.969, green: 0.973, blue: 0.976, alpha: 1)
        }
    }()
}
