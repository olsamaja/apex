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

        let header = ContentRowModel(.text("Reviews (2)"))
        let review1 = Review(title: "title1", author: "author2", rating: "1", content: "content1", version: "1.2.1", updated: Date())
        let review2 = Review(title: "title2", author: "author2", rating: "2", content: "content2", version: "1.2.2", updated: Date())

        let sections = SectionRowsModel.makeReviewsSectionModel(with: [ReviewRowModel(review: review1),
                                                                   ReviewRowModel(review: review2)])
        
        XCTAssertNotNil(sections.header)
        XCTAssertEqual(sections.header!, header)

        XCTAssertNotNil(sections.rows)
        
        let rows = sections.rows!
        XCTAssertEqual(rows.count, 2)
        XCTAssertEqual(rows[0].category, .review(ReviewRowModel(review: review1)))
        XCTAssertEqual(rows[1].category, .review(ReviewRowModel(review: review2)))
    }
}
