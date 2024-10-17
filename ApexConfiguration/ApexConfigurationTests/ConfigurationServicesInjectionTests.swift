//
//  ConfigurationServicesInjectionTests.swift
//  ApexConfigurationTests
//
//  Created by Olivier Rigault on 15/07/2021.
//

import Testing
@testable import ApexCore
@testable import ApexConfiguration
@testable import Resolver

struct ConfigurationServicesInjectionTests {
    
    class Dummy {}
    
    func successfulInjection() throws {
        
        Resolver.registerConfigurationServices(with: Bundle(for: Dummy.self))
        let configuration: Configuration = Resolver.resolve()
        
        #expect(configuration != nil)
        #expect(configuration.scheme == Configuration.Scheme.https)
        #expect(configuration.host == "www.thisisahost.com")
    }
    
    func unsuccessfulInjection() throws {
        
        Resolver.registerConfigurationServices(with: Bundle())
        let configuration: Configuration? = Resolver.optional()
        
        #expect(configuration == nil)
    }
}
