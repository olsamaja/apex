//
//  ConfigurationDataManagerTests.swift
//  ApexConfigurationTests
//
//  Created by Olivier Rigault on 15/07/2021.
//

import XCTest
import Testing
@testable import ApexConfiguration

class ConfigurationDataManagerTests: XCTestCase {
    
    func testWithBundle() throws {
        
        let bundle = Bundle(for: type(of: self))

        do {
            let configuration = try ConfigurationDataManager.load(with: bundle)
            
            #expect(configuration.scheme == Configuration.Scheme.https)
            #expect(configuration.host == "www.thisisahost.com")
        } catch {
            #expect(Bool(false), "\(error.localizedDescription)")
        }
    }
    
    func testWithInvalidBundle() throws {
        
        let bundle = Bundle()

        do {
            let configuration = try ConfigurationDataManager.load(with: bundle)
            
            #expect(configuration == nil)
        } catch (let error) {
            #expect(error != nil)
        }
    }

}
