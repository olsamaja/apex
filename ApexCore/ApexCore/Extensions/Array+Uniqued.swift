//
//  Array+Uniqued.swift
//  ApexCore
//
//  Created by Olivier Rigault on 10/11/2023.
//

import Foundation

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
