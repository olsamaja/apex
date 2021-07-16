//
//  ConfigurationDataManagerTests.swift
//  ApexConfigurationTests
//
//  Created by Olivier Rigault on 15/07/2021.
//

import XCTest
@testable import ApexConfiguration

class ConfigurationDataManagerTests: XCTestCase {
    
    func testWithBundle() throws {
        
        let bundle = Bundle(for: type(of: self))

        do {
            let configuration = try ConfigurationDataManager.load(with: bundle)
            
            XCTAssertEqual(configuration.scheme, Configuration.Scheme.https)
            XCTAssertEqual(configuration.host, "www.thisisahost.com")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testWithInvalidBundle() throws {
        
        let bundle = Bundle()

        do {
            let configuration = try ConfigurationDataManager.load(with: bundle)
            
            XCTAssertNil(configuration)
        } catch (let error) {
            XCTAssertNotNil(error)
        }
    }

}
