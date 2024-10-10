//
//  ConfigurationDTOMapperTests.swift
//  ApexConfigurationTests
//
//  Created by Olivier Rigault on 15/07/2021.
//

import XCTest
import Testing
@testable import ApexConfiguration

class ConfigurationDTOMapperTests: XCTestCase {
    
    func testSuccessfulMapper() throws {
        
        let scheme = "https"
        let host = "www.thisisahost.com"
        
        let dto = ConfigurationDTO(scheme: scheme, host: host)
        do {
            let configuration = try ConfigurationDTOMapper.map(dto)
            #expect(configuration.scheme == Configuration.Scheme.https)
            #expect(configuration.host == host)
        } catch {
            #expect(Bool(false), "\(error.localizedDescription)")
        }
    }

    func testValidScheme() throws {
        
        let dto1 = ConfigurationDTO(scheme: "http", host: "host")
        try checkValidScheme(dto: dto1)
        
        let dto2 = ConfigurationDTO(scheme: "https", host: "host")
        try checkValidScheme(dto: dto2)
    }

    func testInvalidScheme() throws {
        
        let dto = ConfigurationDTO(scheme: "thisisnotascheme", host: "host")
        do {
            let _ = try ConfigurationDTOMapper.map(dto)
            XCTFail("Expected scheme property to be invalid")
        } catch ConfigurationDTOMapper.ValidationError.invalid(let property){
            #expect(property == .scheme)
        } catch {
            #expect(Bool(false), "\(error.localizedDescription)")
        }
    }

    func testMissingProperties() throws {
        
        let dto1 = ConfigurationDTO(scheme: nil, host: "host")
        try checkMissingProperty(dto: dto1, with: ConfigurationDTOMapper.ValidationError.empty(.scheme))
        
        let dto2 = ConfigurationDTO(scheme: "https", host: nil)
        try checkMissingProperty(dto: dto2, with: ConfigurationDTOMapper.ValidationError.empty(.host))
    }

    // MARK: - Helpers

    private func checkValidScheme(dto: ConfigurationDTO) throws {
        do {
            let _ = try ConfigurationDTOMapper.map(dto)
        } catch {
            #expect(Bool(false), "\(error.localizedDescription)")
        }
    }

    private func checkMissingProperty(dto: ConfigurationDTO, with validationError: ConfigurationDTOMapper.ValidationError) throws {
        do {
            let _ = try ConfigurationDTOMapper.map(dto)
            #expect(Bool(false), "Expected property to be missing")
        } catch ConfigurationDTOMapper.ValidationError.empty(let property) {
            #expect(validationError == ConfigurationDTOMapper.ValidationError.empty(property))
        } catch {
            #expect(Bool(false), "\(error.localizedDescription)")
        }
    }

}

// MARK: - ConfigurationDTOMapper.ValidationError : Equatable

extension ConfigurationDTOMapper.ValidationError : Equatable {

    public static func ==(lhs: ConfigurationDTOMapper.ValidationError, rhs: ConfigurationDTOMapper.ValidationError) -> Bool {
        switch (lhs, rhs) {
        case (.empty(let lhsProperty), .empty(let rhsProperty)):
            return lhsProperty == rhsProperty
        case (.invalid(let lhsProperty), .invalid(let rhsProperty)):
            return lhsProperty == rhsProperty
        default:
            return false
        }
    }
}
