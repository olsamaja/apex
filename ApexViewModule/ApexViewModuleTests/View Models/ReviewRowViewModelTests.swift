//
//  ReviewRowViewModelTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 09/11/2023.
//

import XCTest
@testable import ApexCore
@testable import ApexViewModule

final class ReviewRowViewModelTests: XCTestCase {

    func testProperties() throws {
        
        let review = Review(title: "title1", author: "author2", rating: "1", content: "content1", version: "1.2.1", updated: Date())
        let model = ReviewRowViewModel(review: review)
        
        XCTAssertEqual(model.title, review.title)
        XCTAssertEqual(model.author, review.author)
        XCTAssertEqual(model.content, review.content)
        XCTAssertEqual(model.version, "v" + review.version)
        XCTAssertEqual(model.rating, review.rating)
        XCTAssertEqual(model.updated, review.updated.toString())
    }
}
