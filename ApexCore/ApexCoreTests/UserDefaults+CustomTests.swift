//
//  UserDefaults+CustomTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 01/12/2021.
//

import XCTest
import Testing
@testable import ApexCore

class UserDefaults_CustomTests: XCTestCase {

    func testStoreValue() throws {
        let simple = CodableSimpleStruct(code: "key", name: "name")
        UserDefaults.standard.setCustomObject(simple, forKey: "MY_KEY")
        let storedValue: CodableSimpleStruct? = UserDefaults.standard.customObject(forKey: "MY_KEY")
        #expect(storedValue == simple)
    }

    
    func testStoreNilValue() throws {
        let simple: CodableSimpleStruct? = nil
        UserDefaults.standard.setCustomObject(simple, forKey: "MY_KEY")
        let storedValue: CodableSimpleStruct? = UserDefaults.standard.customObject(forKey: "MY_KEY")
        #expect(storedValue == nil)
    }

}

struct CodableSimpleStruct: Codable, Equatable {
    let code: String
    let name: String
}
