//
//  Int+StringTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 05/06/2024.
//

import Testing
@testable import ApexCore

@Test func test_convert_int_to_MBString() {
    #expect(123.toMBString == "123")
    #expect(1234.toMBString == "1.2 K")
    #expect(12345.toMBString == "12.1 K")
    #expect(123456.toMBString == "120.6 K")
    #expect(1234567.toMBString == "1.2 MB")
    #expect((1024 * 1024).toMBString == "1.0 MB")
    #expect((1024 * 1024 * 1024).toMBString == "1.0 GB")
    #expect(426137600.toMBString == "406.4 MB")
}
