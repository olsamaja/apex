//
//  Data+PrintTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 09/05/2024.
//

import XCTest
@testable import ApexCore

final class Data_PrintTests: XCTestCase {

    func testValidJsonData() throws {
        let data: Data? = "{\"name\":\"John\", \"age\":30, \"car\":null}".data(using: .utf8)
        let jsonString = """
        {
          "name" : "John",
          "age" : 30,
          "car" : null
        }
        """
        if let prettyPrintedJSONString = data?.prettyPrintedJSONString {
            XCTAssertEqual(prettyPrintedJSONString, NSString(string: jsonString))
        } else {
            XCTAssert(false, "Unable to convert mock json to String")
        }
    }

    func testInvalidJsonData() throws {
        let data: Data? = "Not a valid json string".data(using: .utf8)
        if let _ = data?.prettyPrintedJSONString {
            XCTAssert(false, "Invalid json string should be converted to a pretty json string")
        } else {
            XCTAssert(true)
        }
    }
}
