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
    
    func testFilterReviewsByDate() {
        
        let expectation = XCTestExpectation(description: "Build review graph data from reviews json file")
        
        let publisher = reviewsPublisher()
            .sink(receiveCompletion: { _ in }) { reviews in
                XCTAssertEqual(reviews.count, 50)

                let dateFormatter = ISO8601DateFormatter()
                guard let endDate = dateFormatter.date(from: "2024-06-09T12:02:57-07:00") else {
                    XCTAssert(false, "Start date cannot be nil")
                    return
                }

                let lastSevenDaysReviews = reviews.filter{ review in Calendar.current.isWithin(numberOfDays: 7, from: review.updated, and: endDate) }
                XCTAssertEqual(lastSevenDaysReviews.count, 30)
                
                let graphDataItems = GraphData(endDate: endDate, numberOfDays: 7, reviews: lastSevenDaysReviews).getItems()
                XCTAssertEqual(graphDataItems.count, 30)
                XCTAssertEqual(graphDataItems[0].daysSinceEndDate, 0)
                XCTAssertEqual(graphDataItems[29].daysSinceEndDate, 6)

                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 2)
        publisher.cancel()
    }

    enum Constants {
        static let dateStrings = ["2024-06-09T12:02:57-07:00", "2024-06-09T09:42:43-07:00", "2024-06-09T09:19:48-07:00",
                                  "2024-06-09T07:05:31-07:00", "2024-06-08T15:19:42-07:00", "2024-06-08T06:45:39-07:00",
                                  "2024-06-07T18:59:09-07:00", "2024-06-07T13:05:36-07:00", "2024-06-07T09:14:11-07:00",
                                  "2024-06-07T08:15:13-07:00", "2024-06-06T15:19:15-07:00", "2024-06-06T13:45:34-07:00",
                                  "2024-06-06T11:26:49-07:00", "2024-06-06T10:51:09-07:00", "2024-06-06T09:05:09-07:00",
                                  "2024-06-06T08:52:06-07:00", "2024-06-06T08:42:18-07:00", "2024-06-06T08:22:24-07:00",
                                  "2024-06-06T08:09:10-07:00", "2024-06-06T08:00:33-07:00", "2024-06-06T06:44:16-07:00",
                                  "2024-06-06T06:19:49-07:00", "2024-06-06T03:18:50-07:00", "2024-06-05T10:07:38-07:00",
                                  "2024-06-05T09:35:35-07:00", "2024-06-04T08:51:46-07:00", "2024-06-04T08:18:07-07:00",
                                  "2024-06-03T22:50:00-07:00", "2024-06-03T08:22:59-07:00", "2024-06-03T08:03:34-07:00",
                                  "2024-06-01T01:59:05-07:00", "2024-05-31T10:00:08-07:00", "2024-05-31T05:40:35-07:00",
                                  "2024-05-30T14:24:24-07:00", "2024-05-30T13:00:57-07:00", "2024-05-30T12:13:09-07:00",
                                  "2024-05-30T10:54:33-07:00", "2024-05-30T10:29:16-07:00", "2024-05-30T09:41:20-07:00",
                                  "2024-05-30T09:07:31-07:00", "2024-05-30T08:59:43-07:00", "2024-05-30T08:55:42-07:00",
                                  "2024-05-30T00:10:17-07:00", "2024-05-29T17:36:05-07:00", "2024-05-29T11:05:38-07:00",
                                  "2024-05-29T08:56:03-07:00", "2024-05-29T02:03:18-07:00", "2024-05-28T10:25:07-07:00",
                                  "2024-05-28T04:10:09-07:00", "2024-05-28T00:23:57-07:00"]
    }
    
    func testFilterDatesWithinSeveralDays() {
        let dateFormatter = ISO8601DateFormatter()
        let dates = Constants.dateStrings.map { dateFormatter.date(from: $0) }
        
        let datesWithinSevenDaysFromNow = dates.filter { date in Calendar.current.isWithin(numberOfDays: 7, from: date!, and: dates[0]!) }
        XCTAssertEqual(datesWithinSevenDaysFromNow.count, 30)
        XCTAssertEqual(datesWithinSevenDaysFromNow[0], dateFormatter.date(from: Constants.dateStrings[0]))
        XCTAssertEqual(datesWithinSevenDaysFromNow[29], dateFormatter.date(from: Constants.dateStrings[29]))
    }
    
    func testNumberOfDaysBetweenTwoDates() {
        let dateFormatter = ISO8601DateFormatter()
        let arrayWithStrings = [["end": "2024-06-09T12:02:57-07:00", "date": "2024-06-09T09:42:43-07:00", "days": 0],
                                ["end": "2024-06-09T12:02:57-07:00", "date": "2024-05-29T02:03:18-07:00", "days": -11],
                                ["end": "2024-05-29T02:03:18-07:00", "date": "2024-06-06T03:18:50-07:00", "days": 8]]
        
        let arrayWithDates = arrayWithStrings.map {
            ["end": dateFormatter.date(from: $0["end"] as! String)!, "date": dateFormatter.date(from: $0["date"] as! String)!, "days": $0["days"]]
        }

        for dict in arrayWithDates {
            XCTAssertEqual(Calendar.current.numberOfDaysBetween(dict["end"] as! Date, and: dict["date"] as! Date), dict["days"] as! Int)
        }
    }
}

struct GraphData {
    
    let endDate: Date
    let numberOfDays: Int
    private let reviews: [Review]
    
    init(endDate: Date, numberOfDays: Int, reviews: [Review]) {
        self.endDate = endDate
        self.numberOfDays = numberOfDays
        self.reviews = reviews
    }
    
    func getItems() -> [GraphDataItem] {
        reviews.map { GraphDataItem(review: $0, daysSinceEndDate: Calendar.current.numberOfDaysBetween($0.updated, and: endDate)) }
    }
}

struct GraphDataItem {
    let review: Review
    let daysSinceEndDate: Int
}
