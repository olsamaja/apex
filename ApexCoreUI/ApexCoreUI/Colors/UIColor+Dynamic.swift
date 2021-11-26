//
//  UIColor+Dynamic.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 26/11/2021.
//

import UIKit

extension UIColor {
    
    /// Returns a dynamic colour used for foreground UI elements, such as labels, based on a single colour provided for light mode.
    ///
    var autoDynamic: UIColor {
        
        let dark = self.brighter()
        let highContrast = self.darker()
        let darkHighContrast = dark
        
        return dynamicColor(highContrast: highContrast, dark: dark, darkHighContrast: darkHighContrast)
    }

    /// Returns a dynamic colour used for background UI elements, such as a section header background, based on a single colour provided for light mode.
    ///
    var autoDynamicBackground: UIColor {
        
        let dark = self.darker()
        let highContrast = self.brighter()
        let darkHighContrast = self
        
        return dynamicColor(highContrast: highContrast, dark: dark, darkHighContrast: darkHighContrast)
    }
    
    /// Returns a dynamic colour based on user interface style, accessibility contrast setting, and single colour provided for light mode.
    ///
    /// - parameter highContrast: colour used for light mode and increased (high) contrast
    /// - parameter dark: colour used for dark mode and standard contrast
    /// - parameter darkHighContrast: colour used for dark mode and increased (high) contrast
    ///
    /// - Unspecified user interface style is treated as light mode
    /// - Unspecified accessibility contrast is treated as standard contrast
    ///
    func dynamicColor(highContrast: UIColor? = nil,
                      dark: UIColor,
                      darkHighContrast: UIColor? = nil) -> UIColor {
        return UIColor(dynamicProvider: {
            switch ($0.userInterfaceStyle, $0.accessibilityContrast) {
            case (.dark, .high):
                return darkHighContrast ?? dark
            case (.dark, _):
                return dark
            case (_, .high):
                return highContrast ?? self
            default:
                return self
            }
        })
    }
}
