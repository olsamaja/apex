//
//  DataRequester+ReviewsTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 04/11/2023.
//

import Combine
import Resolver
import XCTest
import Testing
@testable import ApexNetwork
@testable import ApexCore
@testable import ApexViewModule

final class DataRequester_ReviewsTests: XCTestCase {
    
    var dataRequester: DataRequester!
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        Resolver.register { URLSession.makeMockURLSession() as URLSession }
        dataRequester = DataRequester()
    }
    
    override func tearDown() {
        cancellable?.cancel()
    }

    func testGetReviewsApi() {
        #expect(ReviewsApi(appId: 1234, storeCode: "gb").path() == "/gb/rss/customerreviews/id=1234/page=1/mostrecent/json")
        #expect(ReviewsApi(appId: 1234, storeCode: "gb", page: 3).path() == "/gb/rss/customerreviews/id=1234/page=3/mostrecent/json")
    }

    func testGetReviewsSuccessful() {
        
        let bundle = Bundle(for: type(of: self))
        let expectation = XCTestExpectation(description: "Get reviews with json file")
        
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(in: bundle, with: "MockGetReviewsSuccessful")
        
        cancellable = dataRequester.getReviews(with: 0, storeCode: "")
            .sink(receiveCompletion: { _ in }) { response in
                #expect(response.feed.entry.count == 50)
                let review = response.feed.entry.first!
                #expect(review.title == "So slow")
                #expect(review.author == "fatteddy007")
                #expect(review.content == "I have to keep deleting the app and reinstalling it just to see up to date transactions. Terrible slow app")
                #expect(review.rating == "1")
                #expect(review.version == "5.76.0")

                let dateFormatter = ISO8601DateFormatter()
                #expect(review.updated == dateFormatter.date(from: "2024-06-09T12:02:57-07:00") ?? Date())
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 2)
    }

    func testGetReviewsFailWithInvalidFormat() {
        
        let expectation = XCTestExpectation(description: "Invalid json format")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "Invalid")
        
        cancellable = dataRequester.getReviews(with: 0, storeCode: "")
            .sink(receiveCompletion: { completion in
                #expect(completion == .failure(DataError.parsing(description: "The data couldn’t be read because it isn’t in the correct format.")))
                expectation.fulfill()
            }) { _ in }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetReviewsFailWithMissingData() {
        
        let expectation = XCTestExpectation(description: "Valid json with missing data")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "{}")
        
        cancellable = dataRequester.getReviews(with: 0, storeCode: "")
            .sink(receiveCompletion: { completion in
                #expect(completion == .failure(DataError.parsing(description: "The data couldn’t be read because it is missing.")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
    
    func testGetReviewsFailWithInvalidRequest() {
        
        let expectation = XCTestExpectation(description: "Invalid request")
        MockURLProtocol.requestHandler = MockURLProtocol.makeInvalidRequestHandler()
        
        cancellable = dataRequester.getReviews(with: 0, storeCode: "")
            .sink(receiveCompletion: { completion in
                #expect(completion == .failure(DataError.network(description: "The operation couldn’t be completed. (NSURLErrorDomain error -1.)")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
}
