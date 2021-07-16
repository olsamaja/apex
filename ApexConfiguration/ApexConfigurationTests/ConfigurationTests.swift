//
//  ConfigurationTests.swift
//  ApexConfigurationTests
//
//  Created by Olivier Rigault on 15/07/2021.
//

import XCTest
@testable import ApexConfiguration

class ConfigurationTests: XCTestCase {
    
    func testAllSchemes() throws {
        XCTAssertEqual(Configuration.Scheme.allCases, [.http, .https])
    }

    func testValidSchemes() throws {
        XCTAssertEqual(Configuration.Scheme(string: "http"), Configuration.Scheme.http)
        XCTAssertEqual(Configuration.Scheme(string: "https"), Configuration.Scheme.https)
    }

    func testValidScheme() throws {
        XCTAssertNil(Configuration.Scheme(string: "invalid"))
    }

}
