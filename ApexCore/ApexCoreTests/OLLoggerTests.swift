//
//  OLLoggerTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 17/07/2021.
//

import XCTest
import Testing
@testable import ApexCore

class OLLoggerTests: XCTestCase {

    func testConsole() throws {
        OLLogger.info("Test log with no bundle", with: nil)
        OLLogger.info("Test log with default bundle")
        #expect(Bool(true))
    }
}
