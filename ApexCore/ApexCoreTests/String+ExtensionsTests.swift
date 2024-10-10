//
//  String+ExtensionsTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 05/06/2024.
//

import XCTest
import Testing
@testable import ApexCore

final class String_ExtensionsTests: XCTestCase {

    func testToString() throws {
        #expect("426137600".toInt == 426137600)
        #expect("not an integer".toInt == 0)
    }
}
