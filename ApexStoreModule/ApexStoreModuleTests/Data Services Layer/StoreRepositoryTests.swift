//
//  StoreRepositoryTests.swift
//  ApexStoreModuleTests
//
//  Created by Olivier Rigault on 18/11/2021.
//

import XCTest
@testable import ApexStoreModule

class StoreRepositoryTests: XCTestCase {

    func testAllStores() throws {
        let expected = [
            Store(code: "AT", name: "Austria"),
            Store(code: "BR", name: "Brazil"),
            Store(code: "CA", name: "Canada"),
            Store(code: "CN", name: "China"),
            Store(code: "DK", name: "Denmark"),
            Store(code: "FI", name: "Finland"),
            Store(code: "FR", name: "France"),
            Store(code: "DE", name: "Germany"),
            Store(code: "GR", name: "Greece"),
            Store(code: "ID", name: "Indonesia"),
            Store(code: "IT", name: "Italy"),
            Store(code: "JP", name: "Japan"),
            Store(code: "KR", name: "Korea"),
            Store(code: "MY", name: "Malaysia"),
            Store(code: "MX", name: "Mexico"),
            Store(code: "NL", name: "Netherlands"),
            Store(code: "PT", name: "Portugal"),
            Store(code: "RU", name: "Russia"),
            Store(code: "ES", name: "Spain"),
            Store(code: "SE", name: "Sweden"),
            Store(code: "TH", name: "Thailand"),
            Store(code: "TR", name: "Turkey"),
            Store(code: "UK", name: "United Kingdom"),
            Store(code: "US", name: "United States"),
            Store(code: "VN", name: "Vietnam")
        ]
        let allStores = StoreLocalRepository.allStores()

        XCTAssert(allStores == expected, "Expected \(expected), but got \(allStores) instead")
    }

}
