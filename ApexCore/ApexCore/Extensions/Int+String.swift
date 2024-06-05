//
//  Int+String.swift
//  ApexCore
//
//  Created by Olivier Rigault on 05/06/2024.
//

import Foundation

public extension Int {
    
    private static let kilo = 1024.0
    private static let mega = kilo * 1024.0
    private static let giga = mega * 1024.0
    
    var toMBString: String {
        
        let (format, value): (String, Double) = {
            let double = Double(self)
            if double >= Int.giga {
                return ("%0.1f GB", double / Int.giga)
            } else if double >= Int.mega {
                return ("%0.1f MB", double / Int.mega)
            } else if double >= Int.kilo {
                return ("%0.1f K", double / Int.kilo)
            } else {
                return ("%0.f", double)
            }
        }()
        
        return String(format: format, value)
    }
}
