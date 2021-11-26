//
//  UIColor+Brightness.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 26/11/2021.
//

import UIKit

extension UIColor {
    
    enum Constants {
        static let defaultBrightnessAdjustment: CGFloat = 0.2
    }
    
    func brighter(by value: CGFloat = Constants.defaultBrightnessAdjustment) -> UIColor {
        let clamped = value.clamped(from: 0, to: 1)
        return withAdjustedBrightness(by: clamped)
    }
    
    func darker(by value: CGFloat = Constants.defaultBrightnessAdjustment) -> UIColor {
        let clamped = value.clamped(from: 0, to: 1)
        return withAdjustedBrightness(by: -clamped)
    }

    private func withAdjustedBrightness(by value: CGFloat) -> UIColor {
        var hsva: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) = (0.0, 0.0, 0.0, 0.0)
        guard getHue(&hsva.hue, saturation: &hsva.saturation, brightness: &hsva.brightness, alpha: &hsva.alpha) else {
            return UIColor.red
        }
        hsva.brightness += hsva.brightness * value
        return UIColor(hue: hsva.hue, saturation: hsva.saturation, brightness: hsva.brightness, alpha: hsva.alpha)
    }
}
