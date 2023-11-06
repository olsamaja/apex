//
//  String+ParseTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 17/09/2021.
//

import XCTest
import Combine
@testable import ApexCore

class String_ParseTests: XCTestCase {

    private var cancellable: AnyCancellable?
    
    private struct TestDTO: Decodable {
        let firstName: String
        let lastName: String
        let description: String
    }

    override func tearDown() {
        cancellable?.cancel()
    }

    func testParseSuccessful() throws {
        
        let jsonString = """
        {
          "firstName": "Carl",
          "lastName": "Lewis",
          "description": "Athlete"
        }
        """
        
        let expectation = XCTestExpectation(description: "Decoding TestDTO")
        let publisher: AnyPublisher<TestDTO, DataError> = jsonString.parse()

        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in })
            { person in
                XCTAssertEqual(person.firstName, "Carl")
                XCTAssertEqual(person.lastName, "Lewis")
                XCTAssertEqual(person.description, "Athlete")
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1)
    }

    func testParseWithDeletingNewlinesSuccessful() throws {
        
        let jsonString = """
        {
            "firstName": "Carl",
            "lastName": "Lewis",
            "description": "Text with a \n character."
        }
        """
        
        let expectation = XCTestExpectation(description: "Decoding TestDTO")
        let publisher: AnyPublisher<TestDTO, DataError> = jsonString.parse(with: .deletingNewlineCharacters)

        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in })
            { person in
                XCTAssertEqual(person.description, "Text with a  character.")
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1)
    }

    func testParseMissingData() throws {
        
        let jsonString = """
        {
          "missing": "data",
        }
        """
        
        let expectation = XCTestExpectation(description: "Decoding TestDTO")
        let publisher: AnyPublisher<TestDTO, DataError> = jsonString.parse()

        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    let expectedError = ApexCore.DataError.parsing(description: "The data couldn’t be read because it is missing.")
                    XCTAssertEqual(error, expectedError)
                default:
                    XCTAssert(false, "Was expected an error, got a success instead")
                }
                
                expectation.fulfill()
            })
            { _ in }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testParseIncorrectData() throws {
        
        let jsonString = """
        [
          "firstName": "Carl",
          "lastName": "Lewis"
        ]
        """
        
        let expectation = XCTestExpectation(description: "Decoding TestDTO")
        let publisher: AnyPublisher<TestDTO, DataError> = jsonString.parse()

        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    let expectedError = ApexCore.DataError.parsing(description: "The data couldn’t be read because it isn’t in the correct format.")
                    XCTAssertEqual(error, expectedError)
                default:
                    XCTAssert(false, "Was expected an error, got a success instead")
                }
                
                expectation.fulfill()
            })
            { _ in }
        
        wait(for: [expectation], timeout: 1)
    }
}
