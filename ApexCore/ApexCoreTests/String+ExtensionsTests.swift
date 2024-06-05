//
//  String+ExtensionsTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 05/06/2024.
//

import XCTest
@testable import ApexCore

final class String_ExtensionsTests: XCTestCase {

    func testToString() throws {
        XCTAssertEqual("426137600".toInt, 426137600)
        XCTAssertEqual("not an integer".toInt, 0)
    }
}
