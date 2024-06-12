//
//  GraphViewModelTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 05/06/2024.
//

import Combine
import Resolver
import XCTest
@testable import ApexNetwork
@testable import ApexCore
@testable import ApexViewModule

final class GraphViewModelTests: XCTestCase {

    // Get reviews for the tests
    
    var dataManager: DataManager!
    
    override func setUp() {
        Resolver.register { URLSession.makeMockURLSession() as URLSession }
        dataManager = DataManager()
    }

    func reviewsPublisher() -> AnyPublisher<[Review], DataError> {
        let bundle = Bundle(for: type(of: self))
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(in: bundle, with: "MockGetReviewsSuccessful")
        return dataManager.getReviews(appId: 0, storeCode: "")
    }
    
    func testGetReviewsSuccessful() {
        
        let expectation = XCTestExpectation(description: "Get reviews with json file")
        
        let publisher = reviewsPublisher()
            .sink(receiveCompletion: { _ in }) { reviews in
                XCTAssertEqual(reviews.count, 50)
                let review = reviews.first!

                let dateFormatter = ISO8601DateFormatter()
                XCTAssertEqual(review.updated, dateFormatter.date(from: "2024-06-09T12:02:57-07:00") ?? Date())
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 2)
        publisher.cancel()
    }

    // Filter the reviews between two dates
    
    func testDateFormatter() throws {
        let dateFormatter = ISO8601DateFormatter()
        
        // Convert date from ISO8601 with fraction to ISO8601 w/o fraction
        let dateString = "2024-05-30T11:42:44-07:00"
        let iSO8601Date = dateFormatter.date(from: dateString)
        
        let dateStringWithoutFraction = iSO8601Date?.formatted(.iso8601
            .year()
            .month()
            .day()
        )
        
        if var dateStringWithoutFraction = dateStringWithoutFraction {
            dateStringWithoutFraction += "T00:00:00-00:00"
        
            let iSO8601DateWithoutFraction = dateFormatter.date(from: dateStringWithoutFraction)
            print(iSO8601DateWithoutFraction?.description)
        }
    }

    func testExample() throws {
        let dateFormatter = ISO8601DateFormatter()
        let tuples = [(rating: "1", date: "2024-05-30T11:42:44-07:00", author: "auth1"),
                      (rating: "5", date: "2024-06-01T11:42:44-07:00", author: "auth2"),
                      (rating: "4", date: "2024-06-01T11:42:44-07:00", author: "auth3"),
                      (rating: "3", date: "2024-06-03T11:42:44-07:00", author: "auth4"),
                      (rating: "3", date: "2024-06-03T11:42:44-07:00", author: "auth5"),
                      (rating: "3", date: "2024-06-04T11:42:44-07:00", author: "auth6"),
                      (rating: "1", date: "2024-06-06T11:42:44-07:00", author: "auth7"),
                      (rating: "5", date: "2024-06-06T11:42:44-07:00", author: "auth8")]
        let reviews = tuples.map { Review(title: "", author: $0.author, rating: $0.rating, content: "", version: "", updated: dateFormatter.date(from: $0.date) ?? Date()) }
        let model = GraphViewModel(reviews: reviews, numberOfDays: 7)
        
        // Expected data:
        // - array of ReviewData, with:
        //   - day: 1...n
        //   - count: 0 by default, but 1 for any review of the day
        //   - rating: 1...5
        //   - ratingType: positive, neutral, negative
        
        
    }
}
