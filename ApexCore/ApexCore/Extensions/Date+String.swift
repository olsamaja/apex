//
//  Date+String.swift
//  ApexCore
//
//  Created by Olivier Rigault on 17/09/2021.
//

import Foundation

public extension Date {
    
    func toString(format: String = "dd/MM/YYYY") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toMonthString(format: String = "MMM YYYY") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
