//
//  ContentRowModelTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 31/07/2024.
//

import XCTest
import Testing
@testable import ApexCore
@testable import ApexViewModule

final class ContentRowModelTests: XCTestCase {

    private static var releaseDate: Date {
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: "2023-10-30T11:35:32Z") else {
            XCTAssert(false, "Start date cannot be nil")
            return Date()
        }
        return date
    }
    
    enum Constants {
        static let details1 = Details(trackId: 123,
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
        static let details2 = Details(trackId: 456,
                                      trackName: "another name",
                                      averageUserRating: 5.0,
                                      version: "1.2.4",
                                      minimumOsVersion: "13.0",
                                      description: "some other description",
                                      sellerName: "another seller",
                                      fileSizeBytes: 22345678,
                                      userRatingCount: 22345678,
                                      releaseNotes: "some other release notes",
                                      releaseDate: releaseDate)
        static let detailsModel1 = DetailsRowModel(details: Constants.details1)
        static let detailsModel2 = DetailsRowModel(details: Constants.details2)
        static let review1 = Review(title: "title1", author: "author1", rating: "1", content: "content1", version: "1.2.1", updated: releaseDate)
        static let review2 = Review(title: "title2", author: "author2", rating: "2", content: "content2", version: "1.2.2", updated: releaseDate)
    }
    
    func testEquatableModels() throws {
        #expect(ContentRowModel(.text("some text")) == ContentRowModel(.text("some text")))
        
        #expect(ContentRowModel(.details(Constants.detailsModel1)) != ContentRowModel(.details(Constants.detailsModel2)))
        #expect(ContentRowModel(.details(Constants.detailsModel1)) == ContentRowModel(.details(Constants.detailsModel1)))
        #expect(ContentRowModel(.description(Constants.detailsModel1)) == ContentRowModel(.description(Constants.detailsModel1)))
        #expect(ContentRowModel(.release(Constants.detailsModel1)) == ContentRowModel(.release(Constants.detailsModel1)))
        #expect(ContentRowModel(.vitals(Constants.detailsModel1)) == ContentRowModel(.vitals(Constants.detailsModel1)))
        #expect(ContentRowModel(.details(Constants.detailsModel1)) != ContentRowModel(.vitals(Constants.detailsModel1)))
        
        #expect(ContentRowModel(.review(ReviewRowModel(review: Constants.review1))) != ContentRowModel(.review(ReviewRowModel(review: Constants.review1))))

        #expect(ContentRowModel(.graph([Constants.review1, Constants.review1])) == ContentRowModel(.graph([Constants.review1, Constants.review2])))
    }
}
