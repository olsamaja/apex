//
//  CountryRepositoryTests.swift
//  ApexCountryModuleTests
//
//  Created by Olivier Rigault on 18/11/2021.
//

import XCTest
@testable import ApexCountryModule

class CountryRepositoryTests: XCTestCase {

    func testAllCountries() throws {
        let expected = [
            Country(code: "AT", name: "Austria"),
            Country(code: "BR", name: "Brazil"),
            Country(code: "CA", name: "Canada"),
            Country(code: "CN", name: "China"),
            Country(code: "DK", name: "Denmark"),
            Country(code: "FI", name: "Finland"),
            Country(code: "FR", name: "France"),
            Country(code: "DE", name: "Germany"),
            Country(code: "GR", name: "Greece"),
            Country(code: "ID", name: "Indonesia"),
            Country(code: "IT", name: "Italy"),
            Country(code: "JP", name: "Japan"),
            Country(code: "KR", name: "Korea"),
            Country(code: "MY", name: "Malaysia"),
            Country(code: "MX", name: "Mexico"),
            Country(code: "NL", name: "Netherlands"),
            Country(code: "PT", name: "Portugal"),
            Country(code: "RU", name: "Russia"),
            Country(code: "ES", name: "Spain"),
            Country(code: "SE", name: "Sweden"),
            Country(code: "TH", name: "Thailand"),
            Country(code: "TR", name: "Turkey"),
            Country(code: "UK", name: "United Kingdom"),
            Country(code: "US", name: "United States"),
            Country(code: "VN", name: "Vietnam")
        ]
        let allCountries = CountryRepository.allCountries()

        XCTAssert(allCountries == expected, "Expected \(expected), but got \(allCountries) instead")
    }

}
