//
//  CountryRepository.swift
//  ApexCountryModule
//
//  Created by Olivier Rigault on 18/11/2021.
//

import Foundation

struct CountryRepository {
    
    enum Constants {
        static let defaultCountry = Country(code: "UK", name: "United Kingdom")
    }
    
    static func allCountries() -> [Country] {
        let countries = [
            Constants.defaultCountry,
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
            Country(code: "FR", name: "France")
        ]
        
        return countries.sorted { $0.name < $1.name }
    }
    
    static var current: Country {
        get {
            guard let code = currentCode,
                  let country = allCountries().first(where: { $0.code == code }) else {
                return Constants.defaultCountry
            }
            return country
        }
    }
    
    static var currentCode: String? {
        get {
            let defaults = UserDefaults.standard
            return defaults.string(forKey: "Store")
        }
        set(newCode) {
            let defaults = UserDefaults.standard
            defaults.setValue(newCode, forKey: "Store")
        }
    }
}
