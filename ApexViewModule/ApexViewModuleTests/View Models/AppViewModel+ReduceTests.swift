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

    enum Constants {
        static let details = Details(trackId: 123,
                                     trackName: "name", 
                                     averageUserRating: 4.678,
                                     version: "1.2.3",
                                     minimumOsVersion: "12.0",
                                     description: "some description",
                                     sellerName: "seller",
                                     fileSizeBytes: 12345678,
                                     userRatingCount: 12345678)
        static let header = SectionRowsModel(header: ContentRowModel(.text("header")),
                                         rows: [ContentRowModel(.details(DetailsRowModel(details: details)))])
        static let graph = SectionRowsModel(header: ContentRowModel(.text("graph")),
                                         rows: [])
        static let review1 = Review(title: "title1", author: "author1", rating: "1", content: "content1", version: "1.2.1", updated: Date())
        static let review2 = Review(title: "title2", author: "author2", rating: "2", content: "content2", version: "1.2.2", updated: Date())
        static let rows = SectionRowsModel(header: ContentRowModel(.text("reviews")),
                                       rows: [ContentRowModel(.review(ReviewRowModel(review: review1))),
                                              ContentRowModel(.review(ReviewRowModel(review: review2)))])
    }
    
    func testReduceIdle() throws {
        XCTAssertEqual(AppViewModel.reduce(.idle, .onAppear), .loading)
        
        let events: [AppViewModel.Event] = [.onLoaded(Constants.header, Constants.graph, Constants.rows),
                                            .onFailedToLoadData(DataError.invalidRequest)]
        
        events.forEach { event in
            XCTAssertEqual(AppViewModel.reduce(.idle, event), .idle)
        }
    }
    
    func testReduceLoading() throws {
        XCTAssertEqual(AppViewModel.reduce(.loading, .onAppear), .loading)
        XCTAssertEqual(AppViewModel.reduce(.loading, .onLoaded(Constants.header, Constants.graph, Constants.rows)), .loaded([Constants.header] + [Constants.rows]))
        XCTAssertEqual(AppViewModel.reduce(.loading, .onFailedToLoadData(DataError.invalidRequest)), .error(DataError.invalidRequest))
    }
    
    func testReduceLoaded() throws {
        let state = AppViewModel.State.loaded([Constants.header] + [Constants.rows])
        let events: [AppViewModel.Event] = [.onAppear,
                                            .onLoaded(Constants.header, Constants.graph, Constants.rows),
                                            .onFailedToLoadData(DataError.invalidRequest)]
        
        events.forEach { event in
            XCTAssertEqual(AppViewModel.reduce(state, event), state)
        }
    }
    
    func testReduceError() throws {
        let state = AppViewModel.State.error(DataError.invalidRequest)
        let events: [AppViewModel.Event] = [.onAppear,
                                            .onLoaded(Constants.header, Constants.graph, Constants.rows),
                                            .onFailedToLoadData(DataError.invalidRequest)]
        
        events.forEach { event in
            XCTAssertEqual(AppViewModel.reduce(state, event), state)
        }
    }
}
