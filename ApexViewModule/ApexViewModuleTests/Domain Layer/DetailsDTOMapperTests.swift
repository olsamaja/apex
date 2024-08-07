//
//  DetailsDTOMapperTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 09/11/2023.
//

import XCTest
@testable import ApexCore
@testable import ApexViewModule

final class DetailsDTOMapperTests: XCTestCase {

    func testSuccessfulMapper() throws {

        let dateFormatter = ISO8601DateFormatter()
        guard let releaseDate = dateFormatter.date(from: "2023-10-30T11:35:32Z") else {
            XCTAssert(false, "Start date cannot be nil")
            return
        }

        let dto = DetailsDTO(trackId: 123,
                             trackName: "name",
                             averageUserRating: 4.678,
                             version: "1.2.3",
                             artworkUrl: nil,
                             minimumOsVersion: "12.0",
                             description: "some description",
                             sellerName: "seller",
                             fileSizeBytes: "12345678",
                             userRatingCount: 12345678,
                             releaseNotes: "some release notes",
                             releaseDate: releaseDate)

        let details = DetailsDTOMapper.map(dto)
        XCTAssertEqual(details.trackId, 123)
        XCTAssertEqual(details.trackName, "name")
        XCTAssertEqual(details.averageUserRating, 4.678)
        XCTAssertEqual(details.version, "1.2.3")
        XCTAssertEqual(details.releaseNotes, "some release notes")
        XCTAssertEqual(details.releaseDate, releaseDate)
    }
}
