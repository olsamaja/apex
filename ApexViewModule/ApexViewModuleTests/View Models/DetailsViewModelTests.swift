//
//  DetailsViewModelTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 30/07/2024.
//

import XCTest
@testable import ApexCore
@testable import ApexViewModule

final class DetailsViewModelTests: XCTestCase {

    func testExample() throws {
        let dateFormatter = ISO8601DateFormatter()
        guard let releaseDate = dateFormatter.date(from: "2023-10-30T11:35:32Z") else {
            XCTAssert(false, "Start date cannot be nil")
            return
        }
        
        let details = Details(trackId: 123,
                              trackName: "name",
                              averageUserRating: 4.678,
                              version: "1.2.3",
                              minimumOsVersion: "12.0",
                              description: "some description",
                              sellerName: "seller",
                              fileSizeBytes: 12345678,
                              userRatingCount: 12345678,
                              releaseNotes: "some release notes",
                              releaseDate: releaseDate)
        
        let model = DetailsViewModel(details: details)
        let sections = model.sections
        
        XCTAssertEqual(sections.count, 2)
        XCTAssertNil(sections[0].header)
        XCTAssertEqual(sections[0].rows!.count, 1)

        XCTAssertNil(sections[1].header)
        XCTAssertEqual(sections[1].rows!.count, 3)
    }
}
