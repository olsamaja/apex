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

        let header = ContentRowModel(.text("App Details"))
        let details = Details(trackId: 123, trackName: "name", averageUserRating: 4.678, version: "1.2.3")
        let sections = SectionModel.makeDetailsSectionModel(with: DetailsRowViewModel(details: details))
        
        XCTAssertNotNil(sections.header)
        XCTAssertEqual(sections.header!, header)

        XCTAssertNotNil(sections.rows)
        
        let rows = sections.rows!
        XCTAssertEqual(rows.count, 1)
        
        let row = rows.first!
        XCTAssertEqual(row.category, .details(DetailsRowViewModel(details: details)))
    }

    func testMakeReviewsSectionModel() throws {

        let header = ContentRowModel(.text("Reviews (2)"))
        let review1 = Review(title: "title1", author: "author2", rating: "1", content: "content1", version: "1.2.1", updated: Date())
        let review2 = Review(title: "title2", author: "author2", rating: "2", content: "content2", version: "1.2.2", updated: Date())

        let sections = SectionModel.makeReviewsSectionModel(with: [ReviewRowViewModel(review: review1),
                                                                   ReviewRowViewModel(review: review2)])
        
        XCTAssertNotNil(sections.header)
        XCTAssertEqual(sections.header!, header)

        XCTAssertNotNil(sections.rows)
        
        let rows = sections.rows!
        XCTAssertEqual(rows.count, 2)
        XCTAssertEqual(rows[0].category, .review(ReviewRowViewModel(review: review1)))
        XCTAssertEqual(rows[1].category, .review(ReviewRowViewModel(review: review2)))
    }
}
