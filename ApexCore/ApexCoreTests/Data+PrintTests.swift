//
//  Data+PrintTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 09/05/2024.
//

import Testing
@testable import ApexCore

struct Data_PrintTests {

    @Test func validJsonData() throws {
        let data: Data? = "{\"name\":\"John\", \"age\":30, \"car\":null}".data(using: .utf8)
        let jsonString = """
        {
          "name" : "John",
          "age" : 30,
          "car" : null
        }
        """
        if let prettyPrintedJSONString = data?.prettyPrintedJSONString {
            #expect(prettyPrintedJSONString == NSString(string: jsonString))
        } else {
            #expect(Bool(false), "Unable to convert mock json to String")
        }
    }

    @Test func invalidJsonData() throws {
        let data: Data? = "Not a valid json string".data(using: .utf8)
        if let _ = data?.prettyPrintedJSONString {
            #expect(Bool(false), "Invalid json string should be converted to a pretty json string")
        } else {
            #expect(Bool(true))
        }
    }
}
