//
//  DetailsRowViewModelTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 09/11/2023.
//

import XCTest
import Testing
@testable import ApexCore
@testable import ApexViewModule

final class DetailsRowViewModelTests: XCTestCase {

    func testProperties() throws {
        
        let dateFormatter = ISO8601DateFormatter()
        guard let releaseDate = dateFormatter.date(from: "2023-10-30T11:35:32Z") else {
            #expect(Bool(false), "Start date cannot be nil")
            return
        }
        
        let artworkUrl100 = URL(string: "https://www.artwork.com")

        let details = Details(trackId: 123,
                              trackName: "name",
                              averageUserRating: 4.678,
                              version: "1.2.3",
                              artworkUrl100: artworkUrl100,
                              minimumOsVersion: "12.0",
                              description: "some description",
                              sellerName: "seller",
                              fileSizeBytes: 12345678,
                              userRatingCount: 12345678,
                              releaseNotes: "some release notes",
                              releaseDate: releaseDate)
        
        let model = DetailsRowModel(details: details)
        
        #expect(model.trackName == details.trackName)
        #expect(model.version == "Version " + details.version)
        #expect(model.rating == details.averageUserRating)
        #expect(model.artwork == artworkUrl100)
        #expect(model.releaseDate == "30/10/2023")
    }
}
