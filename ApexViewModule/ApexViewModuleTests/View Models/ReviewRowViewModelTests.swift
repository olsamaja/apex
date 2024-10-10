//
//  ReviewRowViewModelTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 09/11/2023.
//

import XCTest
import Testing
@testable import ApexCore
@testable import ApexViewModule

final class ReviewRowViewModelTests: XCTestCase {

    func testProperties() throws {
        
        let review = Review(title: "title1", author: "author2", rating: "1", content: "content1", version: "1.2.1", updated: Date())
        let model = ReviewRowModel(review: review)
        
        #expect(model.title == review.title)
        #expect(model.author == review.author)
        #expect(model.content == review.content)
        #expect(model.version == "v" + review.version)
        #expect(model.rating == review.rating)
        #expect(model.updated == review.updated.toString())
    }
    
    func testEquatableModels() throws {
        let review = Review(title: "title1", author: "author2", rating: "1", content: "content1", version: "1.2.1", updated: Date())
        let model1 = ReviewRowModel(review: review)
        let model2 = ReviewRowModel(review: review)

        #expect(model1 == model2)
    }
}
