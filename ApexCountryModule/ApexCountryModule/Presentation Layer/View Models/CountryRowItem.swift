//
//  CountryRowItem.swift
//  ApexCountryModule
//
//  Created by Olivier Rigault on 17/11/2021.
//

import Foundation

public struct CountryRowItem: Identifiable {
    
    public let id: String
    let country: Country

    init(country: Country) {
        self.id = UUID().uuidString
        self.country = country
    }
}

extension Array where Element == CountryRowItem {
    
    func sortedByCountryName() -> Array {
        self.sorted { $0.country.name < $1.country.name }
    }
}
