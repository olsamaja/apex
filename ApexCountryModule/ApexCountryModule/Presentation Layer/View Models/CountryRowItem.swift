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

    static func allCountries() -> [CountryRowItem] {
        CountryRepository.allCountries().map { CountryRowItem(country: $0) }
    }
}
//
//extension Array where Element == CountryRowItem {
//    
//    func sortedByCountryName() -> Array {
//        self.sorted { $0.country.name < $1.country.name }
//    }
//}
//
//extension CountryRowItem: Equatable {
//    public static func == (lhs: CountryRowItem, rhs: CountryRowItem) -> Bool { lhs.country == rhs.country }
//}
