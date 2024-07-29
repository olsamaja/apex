//
//  SectionModelTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 09/11/2023.
//

import XCTest
@testable import ApexCore
@testable import ApexViewModule

final class SectionModelTests: XCTestCase {

    func testMakeDetailsSectionModel() throws {

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
        
        let sections = SectionRowsModel.makeDetailsSectionModel(with: DetailsRowModel(details: details))
        
        XCTAssertNil(sections.header)
        XCTAssertNotNil(sections.rows)
        
        let rows = sections.rows!
        XCTAssertEqual(rows.count, 1)
        
        let row = rows.first!
        XCTAssertEqual(row.category, .details(DetailsRowModel(details: details)))
    }

    func testMakeReviewsSectionModel() throws {

        let dateFormatter = ISO8601DateFormatter()
        let dateStrings = ["2023-10-30T11:35:32Z", "2023-10-28T11:35:32Z", "2023-12-30T11:35:32Z"]
        
        let dates = dateStrings.map {
            dateFormatter.date(from: $0) ?? Date()
        }
        
        let reviews = dates.map { date in
            Review(title: "title1", author: "author2", rating: "1", content: "content1", version: "1.2.1", updated: date)
        }
        
        let reviewRowModels = reviews.map { review in
            ReviewRowModel(review: review)
        }
        
        let sections = SectionRowsModel.makeReviewsSectionModelsPerMonth(with: reviewRowModels)
        
        XCTAssertEqual(sections.count, 2)
    }
}
