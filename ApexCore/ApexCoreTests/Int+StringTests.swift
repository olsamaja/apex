//
//  Int+StringTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 05/06/2024.
//

import XCTest
@testable import ApexCore

final class Int_StringTests: XCTestCase {

    func testMBString() throws {
        XCTAssertEqual(123.toMBString, "123")
        XCTAssertEqual(1234.toMBString, "1.2 K")
        XCTAssertEqual(12345.toMBString, "12.1 K")
        XCTAssertEqual(123456.toMBString, "120.6 K")
        XCTAssertEqual(1234567.toMBString, "1.2 MB")
        XCTAssertEqual((1024 * 1024).toMBString, "1.0 MB")
        XCTAssertEqual((1024 * 1024 * 1024).toMBString, "1.0 GB")
        XCTAssertEqual(426137600.toMBString, "406.4 MB")
    }
}
