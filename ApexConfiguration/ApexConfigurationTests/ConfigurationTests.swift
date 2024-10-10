//
//  ConfigurationTests.swift
//  ApexConfigurationTests
//
//  Created by Olivier Rigault on 15/07/2021.
//

import XCTest
import Testing
@testable import ApexConfiguration

class ConfigurationTests: XCTestCase {
    
    func testAllSchemes() throws {
        #expect(Configuration.Scheme.allCases == [.http, .https])
    }

    func testValidSchemes() throws {
        #expect(Configuration.Scheme(string: "http") == Configuration.Scheme.http)
        #expect(Configuration.Scheme(string: "https") == Configuration.Scheme.https)
    }

    func testValidScheme() throws {
        #expect(Configuration.Scheme(string: "invalid") == nil)
    }

}
