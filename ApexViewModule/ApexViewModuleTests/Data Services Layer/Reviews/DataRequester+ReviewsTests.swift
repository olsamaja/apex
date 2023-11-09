//
//  DataRequester+ReviewsTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 04/11/2023.
//

import Combine
import Resolver
import XCTest
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

    func testGetReviewsSuccessful() {
        
        let bundle = Bundle(for: type(of: self))
        let expectation = XCTestExpectation(description: "Get reviews with json file")
        
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(in: bundle, with: "MockGetReviewsSuccessful")
        
        cancellable = dataRequester.getReviews(with: 0)
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertEqual(response.feed.entry.count, 2)
                let review = response.feed.entry.first!
                XCTAssertEqual(review.title, "Great")
                XCTAssertEqual(review.author, "Jay007andrews")
                XCTAssertEqual(review.content, "Easy to get in touch with the call centre after a nightmare of a day ha. Thanks Andrea. 🙂")
                XCTAssertEqual(review.rating, "5")
                XCTAssertEqual(review.version, "5.47.0")

                let dateFormatter = ISO8601DateFormatter()
                XCTAssertEqual(review.updated, dateFormatter.date(from: "2023-10-31T11:42:44-07:00") ?? Date())
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 2)
    }

    func testGetReviewsFailWithInvalidFormat() {
        
        let expectation = XCTestExpectation(description: "Invalid json format")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "Invalid")
        
        cancellable = dataRequester.getReviews(with: 0)
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.parsing(description: "The data couldn’t be read because it isn’t in the correct format.")))
                expectation.fulfill()
            }) { _ in }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetReviewsFailWithMissingData() {
        
        let expectation = XCTestExpectation(description: "Valid json with missing data")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "{}")
        
        cancellable = dataRequester.getReviews(with: 0)
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.parsing(description: "The data couldn’t be read because it is missing.")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
    
    func testGetReviewsFailWithInvalidRequest() {
        
        let expectation = XCTestExpectation(description: "Invalid request")
        MockURLProtocol.requestHandler = MockURLProtocol.makeInvalidRequestHandler()
        
        cancellable = dataRequester.getReviews(with: 0)
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.network(description: "The operation couldn’t be completed. (NSURLErrorDomain error -1.)")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
}

final class DataManager_ReviewsTests: XCTestCase {
    
    var dataManager: DataManager!
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        Resolver.register { URLSession.makeMockURLSession() as URLSession }
        dataManager = DataManager()
    }
    
    override func tearDown() {
        cancellable?.cancel()
    }

    func testGetReviewsSuccessful() {
        
        let bundle = Bundle(for: type(of: self))
        let expectation = XCTestExpectation(description: "Get reviews with json file")
        
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(in: bundle, with: "MockGetReviewsSuccessful")
        
        cancellable = dataManager.getReviews(appId: 0)
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertEqual(response.count, 2)
                let review = response.first!
                XCTAssertEqual(review.title, "Great")
                XCTAssertEqual(review.author, "Jay007andrews")
                XCTAssertEqual(review.content, "Easy to get in touch with the call centre after a nightmare of a day ha. Thanks Andrea. 🙂")
                XCTAssertEqual(review.rating, "5")
                XCTAssertEqual(review.version, "5.47.0")

                let dateFormatter = ISO8601DateFormatter()
                XCTAssertEqual(review.updated, dateFormatter.date(from: "2023-10-31T11:42:44-07:00") ?? Date())
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 2)
    }

    func testGetReviewsFailWithInvalidFormat() {
        
        let expectation = XCTestExpectation(description: "Invalid json format")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "Invalid")
        
        cancellable = dataManager.getReviews(appId: 0)
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.parsing(description: "The data couldn’t be read because it isn’t in the correct format.")))
                expectation.fulfill()
            }) { _ in }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetReviewsFailWithMissingData() {
        
        let expectation = XCTestExpectation(description: "Valid json with missing data")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "{}")
        
        cancellable = dataManager.getReviews(appId: 0)
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.parsing(description: "The data couldn’t be read because it is missing.")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
    
    func testGetReviewsFailWithInvalidRequest() {
        
        let expectation = XCTestExpectation(description: "Invalid request")
        MockURLProtocol.requestHandler = MockURLProtocol.makeInvalidRequestHandler()
        
        cancellable = dataManager.getReviews(appId: 0)
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.network(description: "The operation couldn’t be completed. (NSURLErrorDomain error -1.)")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
}
