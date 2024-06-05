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
        
        let details = Details(trackId: 123,
                              trackName: "name",
                              averageUserRating: 4.678,
                              version: "1.2.3",
                              minimumOsVersion: "12.0",
                              description: "some description",
                              sellerName: "seller",
                              fileSizeBytes: 12345678,
                              userRatingCount: 12345678)
        let model = DetailsRowModel(details: details)
        
        XCTAssertEqual(model.trackName, details.trackName)
        XCTAssertEqual(model.version, "Version: v" + details.version)
        XCTAssertEqual(model.rating, details.averageUserRating)
    }
}
