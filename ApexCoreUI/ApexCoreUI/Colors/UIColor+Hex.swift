//
//  UIColor+Hex.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 26/11/2021.
//

import UIKit

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0, `default`: UIColor = UIColor.clear) {
        let r, g, b: CGFloat
        
        if hex.hasPrefix("0x") {
            let start = hex.index(hex.startIndex, offsetBy: 2)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255.0
                    g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255.0
                    b = CGFloat(hexNumber & 0x000000ff) / 255.0

                    self.init(red: r, green: g, blue: b, alpha: alpha)
                    return
                }
            }
        }
        
        self.init(cgColor: `default`.cgColor)
    }
}
