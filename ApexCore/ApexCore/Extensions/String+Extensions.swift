//
//  String+Extensions.swift
//  ApexCore
//
//  Created by Olivier Rigault on 05/06/2024.
//

import Foundation

public extension String {
    
    var toInt: Int {
        Int(self) ?? 0
    }
}
