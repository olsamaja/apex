//
//  DataErrorTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 14/05/2024.
//

import XCTest
import Testing
@testable import ApexCore

final class DataErrorTests: XCTestCase {

    func testDataErrorDescriptions() throws {
        #expect(DataError.invalidRequest.description == "There is a problem with the request.")
        #expect(DataError.invalidResponse.description == "The server responds with an unexpected format or status code.")
        #expect(DataError.parsing(description: "error 1").description == "The data cannot be parsed: error 1.")
        #expect(DataError.network(description: "error 2").description == "There is an unexpected error with the network: error 2.")
    }

}
