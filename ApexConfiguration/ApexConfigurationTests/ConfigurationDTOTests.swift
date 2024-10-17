//
//  ConfigurationDTOTests.swift
//  ApexConfigurationTests
//
//  Created by Olivier Rigault on 15/07/2021.
//

import Testing
@testable import ApexConfiguration

struct ConfigurationDTOTests {
    
    class Dummy {}
    
    @Test func validBundle() {
        
        let bundle = Bundle(for: Dummy.self)
        let configuration = ConfigurationDTO(with: bundle)
        
        #expect(configuration.scheme == "https")
        #expect(configuration.host == "www.thisisahost.com")
    }
}
