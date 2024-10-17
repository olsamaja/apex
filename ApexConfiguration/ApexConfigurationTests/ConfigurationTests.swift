//
//  ConfigurationTests.swift
//  ApexConfigurationTests
//
//  Created by Olivier Rigault on 15/07/2021.
//

import Testing
@testable import ApexConfiguration

struct ConfigurationTests {
    
    @Test func allSchemes() throws {
        #expect(Configuration.Scheme.allCases == [.http, .https])
    }

    @Test func validSchemes() throws {
        #expect(Configuration.Scheme(string: "http") == Configuration.Scheme.http)
        #expect(Configuration.Scheme(string: "https") == Configuration.Scheme.https)
    }

    @Test func invalidScheme() throws {
        #expect(Configuration.Scheme(string: "invalid") == nil)
    }
}
