//
//  Color+Extensions.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 26/11/2021.
//

import SwiftUI

public extension Color {
    static var searchBarBackground: Color { Color(UIColor.searchBarBackground) }
}

public extension UIColor {
    static var searchBarBackground: UIColor { UIColor(hex: "0xf0f0f0").dynamicColor(dark: UIColor(hex: "0x1c1f1f")) }
}
