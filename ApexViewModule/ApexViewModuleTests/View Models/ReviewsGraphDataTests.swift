//
//  ReviewsGraphDataTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 05/06/2024.
//

import Combine
import Resolver
import XCTest
import Testing
@testable import ApexNetwork
@testable import ApexCore
@testable import ApexViewModule

final class ReviewsGraphDataTests: XCTestCase {

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
                #expect(reviews.count == 50)

                let dateFormatter = ISO8601DateFormatter()
                guard let endDate = dateFormatter.date(from: "2024-06-09T12:02:57-07:00") else {
                    #expect(Bool(false), "Start date cannot be nil")
                    return
                }

                let graphData = ReviewsGraphDataBuilder()
                    .withEndDate(endDate)
                    .withNumberOfDays(7)
                    .withReviews(reviews)
                    .build()
                
                #expect(graphData.items.count == 30)
                #expect(graphData.items[0].daysSinceEndDate == 0)
                #expect(graphData.items[0].ratingType == .negative)
                #expect(graphData.items[0].weight == 1)
                #expect(graphData.items[29].daysSinceEndDate == 6)
                #expect(graphData.items[29].ratingType == .positive)
                #expect(graphData.items[29].weight == 1)

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
        static let dateFormatter = ISO8601DateFormatter()
        static let tuples = [(rating: "3", date: "2024-06-06T11:42:44-07:00"),
                             (rating: "1", date: "2024-06-05T11:42:44-07:00"),
                             (rating: "4", date: "2024-06-03T11:42:44-07:00"),
                             (rating: "3", date: "2024-06-02T11:42:44-07:00"),
                             (rating: "1", date: "2024-06-01T11:42:44-07:00"),
                             (rating: "5", date: "2024-06-05T11:42:44-07:00")]
        static let endDate = dateFormatter.date(from: tuples[0].date)!
        static let reviews = tuples.map { Review(title: "", author: "", rating: $0.rating, content: "", version: "", updated: dateFormatter.date(from: $0.date)!) }
    }
    
    func testFilterReviewsByDateWithMissingDays() {
        
        let graphData = ReviewsGraphDataBuilder()
            .withEndDate(Constants.endDate)
            .withNumberOfDays(7)
            .withReviews(Constants.reviews)
            .build()
        
        #expect(graphData.items.count == 8)
        #expect(graphData.items[0].daysSinceEndDate == 1)
        #expect(graphData.items[0].ratingType == .negative)
        #expect(graphData.items[0].weight == 1)
        #expect(graphData.items[6].daysSinceEndDate == 3)
        #expect(graphData.items[6].ratingType == .positive)
        #expect(graphData.items[6].weight == 1)
        #expect(graphData.startDateShortString == "30 May")
        #expect(graphData.endDateShortString == "6 Jun")
    }
    
    func testFilterDatesWithinSeveralDays() {
        let dateFormatter = ISO8601DateFormatter()
        let dates = Constants.dateStrings.map { dateFormatter.date(from: $0) }
        
        let datesWithinSevenDaysFromNow = dates.filter { date in Calendar.current.isWithin(numberOfDays: 7, from: date!, and: dates[0]!) }
        #expect(datesWithinSevenDaysFromNow.count == 30)
        #expect(datesWithinSevenDaysFromNow[0] == dateFormatter.date(from: Constants.dateStrings[0]))
        #expect(datesWithinSevenDaysFromNow[29] == dateFormatter.date(from: Constants.dateStrings[29]))
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
            #expect(Calendar.current.numberOfDaysBetween(dict["end"] as! Date, and: dict["date"] as! Date) == dict["days"] as! Int)
        }
    }
    
    func testReviewsByStarData() {
        
        let graphData = ReviewsByStarGraphDataBuilder()
            .withEndDate(Constants.endDate)
            .withNumberOfDays(7)
            .withReviews(Constants.reviews)
            .build()
        
        #expect(graphData.items.count == 5)
        #expect(graphData.items[0].rating == "5")
        #expect(graphData.items[1].rating == "4")
        #expect(graphData.items[2].rating == "3")
        #expect(graphData.items[3].rating == "2")
        #expect(graphData.items[4].rating == "1")
    }
    
    func testAverageRating() {
        
        let graphData = ReviewsByStarGraphDataBuilder()
            .withEndDate(Constants.endDate)
            .withNumberOfDays(7)
            .withReviews(Constants.reviews)
            .build()
        
        #expect(graphData.averageRating == "2.8")
    }
}
