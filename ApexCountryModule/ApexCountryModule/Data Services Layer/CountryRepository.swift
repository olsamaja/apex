//
//  CountryRepository.swift
//  ApexCountryModule
//
//  Created by Olivier Rigault on 18/11/2021.
//

import Foundation

struct CountryRepository {
    
    static func allCountries() -> [Country] {
        let countries = [
            Country(code: "CN", name: "China"),
            Country(code: "DK", name: "Denmark"),
            Country(code: "NL", name: "Netherlands"),
            Country(code: "AT", name: "Austria"),
            Country(code: "CA", name: "Canada"),
            Country(code: "US", name: "United States"),
            Country(code: "FI", name: "Finland"),
            Country(code: "DE", name: "Germany"),
            Country(code: "GR", name: "Greece"),
            Country(code: "ID", name: "Indonesia"),
            Country(code: "IT", name: "Italy"),
            Country(code: "JP", name: "Japan"),
            Country(code: "KR", name: "Korea"),
            Country(code: "MY", name: "Malaysia"),
            Country(code: "BR", name: "Brazil"),
            Country(code: "PT", name: "Portugal"),
            Country(code: "RU", name: "Russia"),
            Country(code: "MX", name: "Mexico"),
            Country(code: "ES", name: "Spain"),
            Country(code: "SE", name: "Sweden"),
            Country(code: "TH", name: "Thailand"),
            Country(code: "TR", name: "Turkey"),
            Country(code: "VN", name: "Vietnam"),
            Country(code: "UK", name: "United Kingdom"),
            Country(code: "FR", name: "France")
        ]
        
        return countries.sorted { $0.name < $1.name }
    }
}
