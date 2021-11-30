//
//  UIApplication+Keyboard.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 30/11/2021.
//

import Foundation
import UIKit

extension UIApplication {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
