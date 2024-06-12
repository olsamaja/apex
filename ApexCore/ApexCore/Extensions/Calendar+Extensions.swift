//
//  Calendar+Extensions.swift
//  ApexCore
//
//  Created by Olivier Rigault on 12/06/2024.
//

import Foundation

public extension Calendar {
    
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let dateComponents = dateComponents([.day], from: fromDate, to: toDate)
        
        guard let numberOfDays = dateComponents.day else { return 0 }
        return numberOfDays
    }
    
    func isWithin(numberOfDays: Int, from: Date, and to: Date) -> Bool {
        let numberOfDaysBetweenDates = numberOfDaysBetween(from, and: to)
        return numberOfDaysBetweenDates <= numberOfDays
    }
}
