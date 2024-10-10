//
//  ConfigurationDTOTests.swift
//  ApexConfigurationTests
//
//  Created by Olivier Rigault on 15/07/2021.
//

import XCTest
import Testing
@testable import ApexConfiguration

class ConfigurationDTOTests: XCTestCase {
    
    func testWithBundle() {
        
        let bundle = Bundle(for: type(of: self))
        let configuration = ConfigurationDTO(with: bundle)
        
        #expect(configuration.scheme == "https")
        #expect(configuration.host == "www.thisisahost.com")
    }
}
