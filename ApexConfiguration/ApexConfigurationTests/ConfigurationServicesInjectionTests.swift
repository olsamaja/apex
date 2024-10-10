//
//  ConfigurationServicesInjectionTests.swift
//  ApexConfigurationTests
//
//  Created by Olivier Rigault on 15/07/2021.
//

import XCTest
import Testing
@testable import ApexCore
@testable import ApexConfiguration
@testable import Resolver

class ConfigurationServicesInjectionTests: XCTestCase {
    
    func testSuccessfulInjection() throws {
        
        Resolver.registerConfigurationServices(with: Bundle(for: type(of: self)))
        let configuration: Configuration = Resolver.resolve()
        
        #expect(configuration != nil)
        #expect(configuration.scheme == Configuration.Scheme.https)
        #expect(configuration.host == "www.thisisahost.com")
    }
    
    func testInvalidInjection() throws {
        
        Resolver.registerConfigurationServices(with: Bundle())
        let configuration: Configuration? = Resolver.optional()
        
        #expect(configuration == nil)
    }

}
