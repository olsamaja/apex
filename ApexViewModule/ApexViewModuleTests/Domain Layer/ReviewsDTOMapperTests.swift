//
//  ReviewsDTOMapperTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 09/11/2023.
//

import XCTest
import Testing
@testable import ApexCore
@testable import ApexViewModule

final class ReviewsDTOMapperTests: XCTestCase {

    @Test("User entries", arguments: [
        [
            UserEntryDTO(title: "title1", author: "author1", rating: "1", version: "1.2.1", content: "content1", updated: Date()),
            UserEntryDTO(title: "title2", author: "author2", rating: "2", version: "1.2.2", content: "content2", updated: Date())
        ]
    ])
    func testSuccessfulMapper(userEntryDTOs: [UserEntryDTO]) throws {
        let dto = ReviewsDTO(feed: UserFeedDTO(entry: userEntryDTOs, link: []))

        let reviews = ReviewsDTOMapper.map(dto)
        #expect(reviews.count == userEntryDTOs.count)
        for i in 0..<reviews.count {
            #expect(reviews[i].title == userEntryDTOs[i].title)
            #expect(reviews[i].author == userEntryDTOs[i].author)
            #expect(reviews[i].rating == userEntryDTOs[i].rating)
            #expect(reviews[i].version == userEntryDTOs[i].version)
            #expect(reviews[i].content == userEntryDTOs[i].content)
        }
    }
}
