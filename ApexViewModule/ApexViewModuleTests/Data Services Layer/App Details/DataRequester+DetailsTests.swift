//
//  DataRequester+DetailsTests.swift
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

final class DataRequester_DetailsTests: XCTestCase {
    
    var dataRequester: DataRequester!
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        Resolver.register { URLSession.makeMockURLSession() as URLSession }
        dataRequester = DataRequester()
    }
    
    override func tearDown() {
        cancellable?.cancel()
    }

    func testGetAppDetails() {
        
        let bundle = Bundle(for: type(of: self))
        let expectation = XCTestExpectation(description: "Get reviews with json file")
        
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(in: bundle, with: "MockGetAppDetailsSuccessful")
        
        cancellable = dataRequester.getDetails(with: 0, storeCode: "gb")
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertEqual(response.trackId, 1052238659)
                XCTAssertEqual(response.trackName, "Monzo - Mobile Banking")
                XCTAssertEqual(response.averageUserRating, 4.6324500000000004007461029686965048313140869140625)
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 2)
    }

    func testGetAppDetailsFailWithInvalidFormat() {
        
        let expectation = XCTestExpectation(description: "Invalid json format")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "Invalid")
        
        cancellable = dataRequester.getDetails(with: 0, storeCode: "gb")
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.parsing(description: "The data couldn’t be read because it isn’t in the correct format.")))
                expectation.fulfill()
            }) { _ in }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetAppDetailsFailWithMissingData() {
        
        let expectation = XCTestExpectation(description: "Valid json with missing data")
        MockURLProtocol.requestHandler = MockURLProtocol.makeRequestHandler(with: "{}")
        
        cancellable = dataRequester.getDetails(with: 0, storeCode: "gb")
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.parsing(description: "The data couldn’t be read because it is missing.")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
    
    func testGetAppDetailsFailWithInvalidRequest() {
        
        let expectation = XCTestExpectation(description: "Invalid request")
        MockURLProtocol.requestHandler = MockURLProtocol.makeInvalidRequestHandler()
        
        cancellable = dataRequester.getDetails(with: 0, storeCode: "gb")
            .sink(receiveCompletion: { completion in
                XCTAssertEqual(completion, .failure(DataError.network(description: "The operation couldn’t be completed. (NSURLErrorDomain error -1.)")))
                  expectation.fulfill()
            }) { _ in }

        wait(for: [expectation], timeout: 2)
    }
}
