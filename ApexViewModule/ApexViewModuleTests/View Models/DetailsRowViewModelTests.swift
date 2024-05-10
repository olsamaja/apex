//
//  DetailsRowViewModelTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 09/11/2023.
//

import XCTest
@testable import ApexCore
@testable import ApexViewModule

final class DetailsRowViewModelTests: XCTestCase {

    func testProperties() throws {
        
        let details = Details(trackId: 123, trackName: "name", averageUserRating: 4.678, version: "1.2.3")
        let model = DetailsRowModel(details: details)
        
        XCTAssertEqual(model.trackName, details.trackName)
        XCTAssertEqual(model.version, "Current version: v" + details.version)
        XCTAssertEqual(model.rating, String(format: "Rating: %.1f", details.averageUserRating))
    }
}