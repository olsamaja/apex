//
//  ConfigurationDataManagerTests.swift
//  ApexConfigurationTests
//
//  Created by Olivier Rigault on 15/07/2021.
//

import Testing
@testable import ApexConfiguration

struct ConfigurationDataManagerTests {
    
    class Dummy {}

    @Test func validBundle() throws {
        
        let bundle = Bundle(for: Dummy.self)

        do {
            let configuration = try ConfigurationDataManager.load(with: bundle)
            
            #expect(configuration.scheme == Configuration.Scheme.https)
            #expect(configuration.host == "www.thisisahost.com")
        } catch {
            #expect(Bool(false), "\(error.localizedDescription)")
        }
    }
    
    @Test func invalidBundle() throws {
        
        let bundle = Bundle()

        do {
            let configuration = try ConfigurationDataManager.load(with: bundle)
            
            #expect(configuration == nil)
        } catch (let error) {
            #expect(error != nil)
        }
    }
}
