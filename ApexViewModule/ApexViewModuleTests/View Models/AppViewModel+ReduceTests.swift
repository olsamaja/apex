//
//  AppViewModel+ReduceTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 09/11/2023.
//

import XCTest
@testable import ApexCore
@testable import ApexViewModule

final class AppViewModel_ReduceTests: XCTestCase {

    private static var releaseDate: Date {
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: "2023-10-30T11:35:32Z") else {
            XCTAssert(false, "Start date cannot be nil")
            return Date()
        }
        return date
    }
    
    enum Constants {
        static let details = Details(trackId: 123,
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
        static let detailsSection = SectionRowsModel(header: ContentRowModel(.text("header")),
                                         rows: [ContentRowModel(.details(DetailsRowModel(details: details)))])
        static let graph = SectionRowsModel(header: ContentRowModel(.text("graph")),
                                         rows: [])
        static let review1 = Review(title: "title1", author: "author1", rating: "1", content: "content1", version: "1.2.1", updated: Date())
        static let review2 = Review(title: "title2", author: "author2", rating: "2", content: "content2", version: "1.2.2", updated: Date())
        static let rows = SectionRowsModel(header: ContentRowModel(.text("reviews")),
                                       rows: [ContentRowModel(.review(ReviewRowModel(review: review1))),
                                              ContentRowModel(.review(ReviewRowModel(review: review2)))])
    }
    
    func testEquatableStates() throws {
        XCTAssertEqual(AppViewModel.State.loadingDetails, AppViewModel.State.loadingDetails)
        XCTAssertEqual(AppViewModel.State.loadingNextReviews([]), AppViewModel.State.loadingNextReviews([Constants.detailsSection]))
        XCTAssertNotEqual(AppViewModel.State.loadingDetails, AppViewModel.State.loadingNextReviews([]))
    }
    
    func testReduceIdle() throws {
        XCTAssertEqual(AppViewModel.reduce(.idle, .onAppear), .loadingDetails)
        
        let events: [AppViewModel.Event] = [.onDetailsLoaded(Constants.detailsSection),
                                            .onFailedToLoadData(DataError.invalidRequest)]
        
        events.forEach { event in
            XCTAssertEqual(AppViewModel.reduce(.idle, event), .idle)
        }
    }
    
    func testReduceLoadingDetails() throws {
        XCTAssertEqual(AppViewModel.reduce(.loadingDetails, .onAppear), .loadingDetails)
        XCTAssertEqual(AppViewModel.reduce(.loadingDetails, .onDetailsLoaded(Constants.detailsSection)), .detailsLoaded(Constants.detailsSection))
        XCTAssertEqual(AppViewModel.reduce(.loadingDetails, .onFailedToLoadData(DataError.invalidRequest)), .error(DataError.invalidRequest))
    }
    
    func testReduceDetailsLoaded() throws {
        let state = AppViewModel.State.detailsLoaded(Constants.detailsSection)
        let events: [AppViewModel.Event] = [.onAppear,
                                            .onDetailsLoaded(Constants.detailsSection),
                                            .onFailedToLoadData(DataError.invalidRequest)]
        
        events.forEach { event in
            XCTAssertEqual(AppViewModel.reduce(state, event), state)
        }

        XCTAssertEqual(AppViewModel.reduce(.detailsLoaded(Constants.detailsSection), 
            .onLoadingNextReviews([Constants.detailsSection])),
            .loadingNextReviews([Constants.detailsSection]))
    }

    func testReduceLoadingNextReviews() throws {
        let initialState = AppViewModel.State.loadingNextReviews([Constants.detailsSection])
        XCTAssertEqual(AppViewModel.reduce(initialState, .onAppear), initialState)

        XCTAssertEqual(AppViewModel.reduce(initialState, .onFailedToLoadData(DataError.invalidRequest)), .error(DataError.invalidRequest))

        let sections = [Constants.detailsSection] + [Constants.rows]
        XCTAssertEqual(AppViewModel.reduce(initialState, .onNextReviewsloaded(sections)), .nextReviewsLoaded(sections))
    }

    func testNextReviewsLoaded() throws {
        let sections = [Constants.detailsSection] + [Constants.rows]
        let state = AppViewModel.State.nextReviewsLoaded(sections)
        let events: [AppViewModel.Event] = [.onAppear,
                                            .onDetailsLoaded(Constants.detailsSection),
                                            .onFailedToLoadData(DataError.invalidRequest)]
        
        events.forEach { event in
            XCTAssertEqual(AppViewModel.reduce(state, event), state)
        }
    }
    
    func testReduceError() throws {
        let state = AppViewModel.State.error(DataError.invalidRequest)
        let events: [AppViewModel.Event] = [.onAppear,
                                            .onDetailsLoaded(Constants.detailsSection),
                                            .onFailedToLoadData(DataError.invalidRequest)]
        
        events.forEach { event in
            XCTAssertEqual(AppViewModel.reduce(state, event), state)
        }
    }
}
