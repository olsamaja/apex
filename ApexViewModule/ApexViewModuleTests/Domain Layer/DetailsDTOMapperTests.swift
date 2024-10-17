//
//  DetailsDTOMapperTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 09/11/2023.
//

import XCTest
import Testing
@testable import ApexCore
@testable import ApexViewModule

final class DetailsDTOMapperTests: XCTestCase {

    func testSuccessfulMapper() {

        let dateFormatter = ISO8601DateFormatter()
        guard let releaseDate = dateFormatter.date(from: "2023-10-30T11:35:32Z") else {
            #expect(Bool(false), "Start date cannot be nil")
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
        #expect(details.trackId == 123)
        #expect(details.trackName == "name")
        #expect(details.averageUserRating == 4.678)
        #expect(details.version == "1.2.3")
        #expect(details.releaseNotes == "some release notes")
        #expect(details.releaseDate == releaseDate)
    }
}
