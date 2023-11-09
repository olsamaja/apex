//
//  ReviewsDTOMapperTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 09/11/2023.
//

import XCTest
@testable import ApexCore
@testable import ApexViewModule

final class ReviewsDTOMapperTests: XCTestCase {

    func testSuccessfulMapper() throws {
        
        let entry1 = UserEntryDTO(title: "title1", author: "author1", rating: "1", version: "1.2.1", content: "content1", updated: Date())
        let entry2 = UserEntryDTO(title: "title2", author: "author2", rating: "2", version: "1.2.2", content: "content2", updated: Date())

        let dto = ReviewsDTO(feed: UserFeedDTO(entry: [entry1, entry2]))

        let reviews = ReviewsDTOMapper.map(dto)
        XCTAssertEqual(reviews.count, 2)
        for i in 0...1 {
            let number = String(i + 1)
            XCTAssertEqual(reviews[i].title, "title" + number)
            XCTAssertEqual(reviews[i].author, "author" + number)
            XCTAssertEqual(reviews[i].rating, number)
            XCTAssertEqual(reviews[i].version, "1.2." + number)
            XCTAssertEqual(reviews[i].content, "content" + number)
        }
    }
}
